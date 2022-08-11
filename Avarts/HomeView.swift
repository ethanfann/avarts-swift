//
//  HomeView.swift
//  Avarts
//
//  Created by Ethan Fann on 3/20/21.
//

import SwiftUI
import WidgetKit

let formatter = NumberFormatter()

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return floor(self * divisor) / divisor
    }
}

func formatDistance(distance: Double, pref: String) -> String {
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 3

    let value: Double = pref == "imperial" ? distance * 0.000621371 : distance * 0.001

    return formatter.string(from: NSNumber(value: value.rounded(toPlaces: 2)))!
}

func formatElevation(elevation: Double, pref: String) -> String {
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 0

    let value: Double = pref == "imperial" ? elevation * 3.28084 : elevation

    return formatter.string(from: NSNumber(value: value))!
}

func distanceLabel(pref: String) -> String {
    return pref == "imperial" ? "mi" : "km"
}

func elevationLabel(pref: String) -> String {
    return pref == "imperial" ? "ft" : "m"
}

struct HomeView: View {
    @EnvironmentObject var authState: AuthenticationState
    let frontendUrl = ProcessInfo.processInfo.environment["BASE_URL"]!

    var body: some View {
        if let user = authState.loggedInUser {
            TabView {
                VStack {
                    Spacer()
                    VStack {
                        Text("\(user.name)").font(.largeTitle)
                            .fontWeight(.bold)
                        RemoteImage(url: user.img)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125, height: 125)
                            .cornerRadius(125)
                    }
                    if let latest = user.latestActivity {
                        VStack {
                            Text("Latest Activity").font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            if latest.id != "0" {
                                Button {
                                    let url = URL(string: "\(frontendUrl)/activity/\(latest.id)")!
                                    if UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url, options: [:], completionHandler: { success in
                                            print("Open url : \(success)")
                                        })
                                    }
                                } label: {
                                    HStack {
                                        Text("\(latest.title)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(red: 252 / 255, green: 76 / 255, blue: 2 / 255))
                                        Image(systemName: "arrow.up.forward.app.fill")
                                            .foregroundColor(Color(red: 252 / 255, green: 76 / 255, blue: 2 / 255))
                                    }
                                }.padding(.bottom, 5)
                                HStack {
                                    VStack {
                                        Text("Distance").font(.title3)
                                            .fontWeight(.bold)
                                        Text("\(formatDistance(distance: Double(latest.distance), pref: user.measurementPreference)) \(distanceLabel(pref: user.measurementPreference))").font(.body)
                                    }.padding(10)
                                    VStack {
                                        Text("Elevation").font(.title3)
                                            .fontWeight(.bold)
                                        Text("\(formatElevation(elevation: Double(latest.elevation), pref: user.measurementPreference)) \(elevationLabel(pref: user.measurementPreference))").font(.body)
                                    }
                                }
                            } else {
                                Text("\(latest.title)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            authState.reload()
                            WidgetCenter.shared.reloadAllTimelines()
                        }) {
                            Text("Refresh")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(Color.accentColor)
                                .cornerRadius(15.0)
                        }
                        Button(action: {
                            authState.logout()
                            WidgetCenter.shared.reloadAllTimelines()
                        }) {
                            Text("Logout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(Color.accentColor)
                                .cornerRadius(15.0)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
