//
//  Avarts_Widget.swift
//  Avarts Widget
//
//  Created by Ethan Fann on 2/23/21.
//

import Intents
import MapKit
import Network
import Polyline
import SwiftUI
import WidgetKit

func drawLineOnImage(snapshot: MKMapSnapshotter.Snapshot, size: CGSize, coordinates: [CLLocationCoordinate2D], color: CGColor) -> UIImage {
    let image = snapshot.image
    
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    
    image.draw(at: CGPoint.zero)
    
    let context = UIGraphicsGetCurrentContext()
    
    context!.setLineWidth(4.0)
    context!.setStrokeColor(color)
    context!.setLineCap(CGLineCap.round)
    
    context!.move(to: snapshot.point(for: coordinates[0]))
    for i in 0 ... coordinates.count - 1 {
        context!.addLine(to: snapshot.point(for: coordinates[i]))
        context!.move(to: snapshot.point(for: coordinates[i]))
    }
    
    context!.strokePath()
    
    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return resultImage!
}

struct Provider: IntentTimelineProvider {
    static let MAP_ZOOM_FACTOR = 1.25
    static let DEFAULT_STROKE_COLOR = "#FF7F50"
    static let lightTraitCollection: UITraitCollection = .init(userInterfaceStyle: UIUserInterfaceStyle.light)
    static let darkTraitCollection: UITraitCollection = .init(userInterfaceStyle: UIUserInterfaceStyle.dark)
    
    private func configuredEntry(for configuration: ConfigurationIntent, images: [ColorScheme: UIImage], distance: Int, elevation: Int) -> SimpleEntry {
        .init(date: Date(),
              configuration: configuration,
              images: images,
              distance: distance,
              elevation: elevation)
    }
    
    private func dummyEntry(for configuration: ConfigurationIntent) -> SimpleEntry {
        .init(date: Date(),
              configuration: configuration,
              images: [
                  .light: UIImage(named: "750x300")!,
                  .dark: UIImage(named: "750x300")!
              ],
              distance: 1000,
              elevation: 100)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        dummyEntry(for: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = dummyEntry(for: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Network.shared.apollo.fetch(query: MeQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                guard let activty = graphQLResult.data?.me?.latestActivity else {
                    return
                }
                
                guard let coordinates: [CLLocationCoordinate2D] = decodePolyline(activty.polyline) else {
                    return
                }
                
                let polyLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
                var region = MKCoordinateRegion(polyLine.boundingMapRect)
                region.span.latitudeDelta = region.span.latitudeDelta * Provider.MAP_ZOOM_FACTOR
                region.span.longitudeDelta = region.span.longitudeDelta * Provider.MAP_ZOOM_FACTOR
                
                let strokeColor: CGColor = UIColor(hex: graphQLResult.data?.me?.strokeColor ?? Provider.DEFAULT_STROKE_COLOR).cgColor

                let mapSnapshotOptions = MKMapSnapshotter.Options()
                mapSnapshotOptions.region = region
                mapSnapshotOptions.scale = UIScreen.main.scale
                mapSnapshotOptions.size = context.displaySize
                mapSnapshotOptions.showsBuildings = true
                mapSnapshotOptions.traitCollection = Provider.lightTraitCollection
                
                let lightImageSnapshotter = MKMapSnapshotter(options: mapSnapshotOptions)
                lightImageSnapshotter.start { lightSnapshotResult, _ in
                    guard let lightSnapshot = lightSnapshotResult else {
                        return
                    }
                    
                    mapSnapshotOptions.traitCollection = Provider.darkTraitCollection
                    let darkImageSnapshotter = MKMapSnapshotter(options: mapSnapshotOptions)
                    darkImageSnapshotter.start { darkImageSnapshotResult, _ in
                        guard let darkImageSnapshot = darkImageSnapshotResult else {
                            return
                        }
                        
                        let imageLight: UIImage = drawLineOnImage(snapshot: lightSnapshot, size: context.displaySize, coordinates: coordinates, color: strokeColor)
                        let imageDark: UIImage = drawLineOnImage(snapshot: darkImageSnapshot, size: context.displaySize, coordinates: coordinates, color: strokeColor)
                                                
                        let newEntry = configuredEntry(for: configuration, images: [.light: imageLight, .dark: imageDark], distance: activty.distance, elevation: activty.elevation)

                        let timeline = Timeline(entries: [newEntry], policy: .atEnd)
                        completion(timeline)
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let images: [ColorScheme: UIImage]
    let distance: Int
    let elevation: Int
}

struct ImageWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if let screenshot = entry.images[colorScheme] {
                Image(uiImage: screenshot)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}

@main
struct ImageWidget: Widget {
    let kind: String = "ImageWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ImageWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Avarts Widget")
        .description("Your latest activity")
    }
}
