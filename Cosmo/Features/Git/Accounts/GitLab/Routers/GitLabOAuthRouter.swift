/* -----------------------------------------------------------
 * :: :  C  O  S  M  O  :                                ::
 * -----------------------------------------------------------
 * @wabistudios :: cosmo :: composer
 *
 * CREDITS.
 *
 * T.Furby              @furby-tm       <devs@wabi.foundation>
 *
 *         Copyright (C) 2023 Wabi Animation Studios, Ltd. Co.
 *                                        All Rights Reserved.
 * -----------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * ----------------------------------------------------------- */

import Foundation

enum GitLabOAuthRouter: GitRouter
{
  case authorize(GitLabOAuthConfiguration, String)
  case accessToken(GitLabOAuthConfiguration, String, String)

  var configuration: GitRouterConfiguration?
  {
    switch self
    {
      case let .authorize(config, _): return config
      case let .accessToken(config, _, _): return config
    }
  }

  var method: GitHTTPMethod
  {
    switch self
    {
      case .authorize:
        return .GET
      case .accessToken:
        return .POST
    }
  }

  var encoding: GitHTTPEncoding
  {
    switch self
    {
      case .authorize:
        return .url
      case .accessToken:
        return .form
    }
  }

  var path: String
  {
    switch self
    {
      case .authorize:
        return "oauth/authorize"
      case .accessToken:
        return "oauth/token"
    }
  }

  var params: [String: Any]
  {
    switch self
    {
      case let .authorize(config, redirectURI):
        return [
          "client_id": config.token as AnyObject,
          "response_type": "code" as AnyObject,
          "redirect_uri": redirectURI as AnyObject,
        ]
      case let .accessToken(config, code, rediredtURI):
        return [
          "client_id": config.token as AnyObject,
          "client_secret": config.secret as AnyObject,
          "code": code as AnyObject, "grant_type":
            "authorization_code" as AnyObject,
          "redirect_uri": rediredtURI as AnyObject,
        ]
    }
  }

  var URLRequest: Foundation.URLRequest?
  {
    switch self
    {
      case let .authorize(config, _):
        let url = URL(string: path, relativeTo: URL(string: config.webEndpoint!)!)
        let components = URLComponents(url: url!, resolvingAgainstBaseURL: true)
        return request(components!, parameters: params)
      case let .accessToken(config, _, _):
        let url = URL(string: path, relativeTo: URL(string: config.webEndpoint!)!)
        let components = URLComponents(url: url!, resolvingAgainstBaseURL: true)
        return request(components!, parameters: params)
    }
  }
}
