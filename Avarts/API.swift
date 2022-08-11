// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class LoginMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation login($email: String!, $password: String!) {
      login(email: $email, password: $password) {
        __typename
        id
        name
        token
        img
        measurementPreference
        latestActivity {
          __typename
          id
          title
          createdAt
          polyline
          elevation
          distance
        }
      }
    }
    """

  public let operationName: String = "login"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("login", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(Login.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> ResultMap in value.resultMap }])
    }

    /// Login for users
    public var login: Login? {
      get {
        return (resultMap["login"] as? ResultMap).flatMap { Login(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
          GraphQLField("img", type: .nonNull(.scalar(String.self))),
          GraphQLField("measurementPreference", type: .nonNull(.scalar(String.self))),
          GraphQLField("latestActivity", type: .object(LatestActivity.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, token: String, img: String, measurementPreference: String, latestActivity: LatestActivity? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "token": token, "img": img, "measurementPreference": measurementPreference, "latestActivity": latestActivity.flatMap { (value: LatestActivity) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var img: String {
        get {
          return resultMap["img"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "img")
        }
      }

      public var measurementPreference: String {
        get {
          return resultMap["measurementPreference"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "measurementPreference")
        }
      }

      public var latestActivity: LatestActivity? {
        get {
          return (resultMap["latestActivity"] as? ResultMap).flatMap { LatestActivity(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "latestActivity")
        }
      }

      public struct LatestActivity: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Activity"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("polyline", type: .nonNull(.scalar(String.self))),
            GraphQLField("elevation", type: .nonNull(.scalar(Int.self))),
            GraphQLField("distance", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, createdAt: String, polyline: String, elevation: Int, distance: Int) {
          self.init(unsafeResultMap: ["__typename": "Activity", "id": id, "title": title, "createdAt": createdAt, "polyline": polyline, "elevation": elevation, "distance": distance])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var createdAt: String {
          get {
            return resultMap["createdAt"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var polyline: String {
          get {
            return resultMap["polyline"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "polyline")
          }
        }

        public var elevation: Int {
          get {
            return resultMap["elevation"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "elevation")
          }
        }

        public var distance: Int {
          get {
            return resultMap["distance"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "distance")
          }
        }
      }
    }
  }
}

public final class MeQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query me {
      me {
        __typename
        id
        name
        email
        img
        latestActivity {
          __typename
          id
          title
          createdAt
          polyline
          elevation
          distance
        }
        activityCount
        firstName
        lastName
        strokeColor
        measurementPreference
      }
    }
    """

  public let operationName: String = "me"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("me", type: .object(Me.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(me: Me? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }])
    }

    /// Returns the current user
    public var me: Me? {
      get {
        return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "me")
      }
    }

    public struct Me: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("img", type: .nonNull(.scalar(String.self))),
          GraphQLField("latestActivity", type: .object(LatestActivity.selections)),
          GraphQLField("activityCount", type: .scalar(Int.self)),
          GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
          GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
          GraphQLField("strokeColor", type: .nonNull(.scalar(String.self))),
          GraphQLField("measurementPreference", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, email: String? = nil, img: String, latestActivity: LatestActivity? = nil, activityCount: Int? = nil, firstName: String, lastName: String, strokeColor: String, measurementPreference: String) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "email": email, "img": img, "latestActivity": latestActivity.flatMap { (value: LatestActivity) -> ResultMap in value.resultMap }, "activityCount": activityCount, "firstName": firstName, "lastName": lastName, "strokeColor": strokeColor, "measurementPreference": measurementPreference])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var img: String {
        get {
          return resultMap["img"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "img")
        }
      }

      public var latestActivity: LatestActivity? {
        get {
          return (resultMap["latestActivity"] as? ResultMap).flatMap { LatestActivity(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "latestActivity")
        }
      }

      public var activityCount: Int? {
        get {
          return resultMap["activityCount"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "activityCount")
        }
      }

      public var firstName: String {
        get {
          return resultMap["firstName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String {
        get {
          return resultMap["lastName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var strokeColor: String {
        get {
          return resultMap["strokeColor"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "strokeColor")
        }
      }

      public var measurementPreference: String {
        get {
          return resultMap["measurementPreference"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "measurementPreference")
        }
      }

      public struct LatestActivity: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Activity"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("polyline", type: .nonNull(.scalar(String.self))),
            GraphQLField("elevation", type: .nonNull(.scalar(Int.self))),
            GraphQLField("distance", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: String, createdAt: String, polyline: String, elevation: Int, distance: Int) {
          self.init(unsafeResultMap: ["__typename": "Activity", "id": id, "title": title, "createdAt": createdAt, "polyline": polyline, "elevation": elevation, "distance": distance])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var createdAt: String {
          get {
            return resultMap["createdAt"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var polyline: String {
          get {
            return resultMap["polyline"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "polyline")
          }
        }

        public var elevation: Int {
          get {
            return resultMap["elevation"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "elevation")
          }
        }

        public var distance: Int {
          get {
            return resultMap["distance"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "distance")
          }
        }
      }
    }
  }
}

public final class PingQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ping {
      ping
    }
    """

  public let operationName: String = "ping"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("ping", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(ping: String) {
      self.init(unsafeResultMap: ["__typename": "Query", "ping": ping])
    }

    /// Ping Pong
    public var ping: String {
      get {
        return resultMap["ping"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "ping")
      }
    }
  }
}
