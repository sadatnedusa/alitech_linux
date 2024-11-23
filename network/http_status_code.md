# HTTP Status Code

| **1XX Information**   | **2XX Success**              | **3XX Redirection**         | **4XX Client Error**           | **5XX Server Error**               |
|------------------------|-----------------------------|-----------------------------|--------------------------------|-------------------------------------|
| 100 Continue           | 200 OK                      | 300 Multiple Choices        | 400 Bad Request                | 500 Internal Server Error          |
| 101 Switching Protocols| 201 Created                 | 301 Moved Permanently       | 401 Unauthorized               | 501 Not Implemented                |
| 102 Processing         | 202 Accepted                | 302 Found                   | 402 Payment Required           | 502 Bad Gateway                    |
| 103 Early Hints        | 203 Non-Authoritative Info  | 303 See Other               | 403 Forbidden                  | 503 Service Unavailable            |
|                        | 204 No Content              | 304 Not Modified            | 404 Not Found                  | 504 Gateway Timeout                |
|                        | 205 Reset Content           | 305 Use Proxy               | 405 Method Not Allowed         | 505 HTTP Version Not Supported     |
|                        | 206 Partial Content         | 306 Unused                  | 406 Not Acceptable             | 507 Insufficient Storage (WebDAV)  |
|                        | 207 Multi-Status (WebDAV)   | 307 Temporary Redirect      | 407 Proxy Auth Required        | 508 Loop Detected (WebDAV)         |
|                        | 208 Already Reported (WebDAV)| 308 Permanent Redirect     | 408 Request Timeout            | 510 Not Extended                   |
|                        | 226 IM Used (HTTP Delta)    |                             | 409 Conflict                   | 511 Network Auth Required          |
|                        |                             |                             | 410 Gone                       |                                     |
|                        |                             |                             | 411 Length Required            |                                     |
|                        |                             |                             | 412 Precondition Failed        |                                     |
|                        |                             |                             | 413 Payload Too Large          |                                     |
|                        |                             |                             | 414 URI Too Large              |                                     |
|                        |                             |                             | 415 Unsupported Media Type     |                                     |
|                        |                             |                             | 416 Range Not Satisfiable      |                                     |
|                        |                             |                             | 417 Expectation Failed         |                                     |
|                        |                             |                             | 418 I'm a teapot               |                                     |
|                        |                             |                             | 421 Misdirected Request        |                                     |
|                        |                             |                             | 422 Unprocessable Entity (WebDAV)|                                   |
|                        |                             |                             | 423 Locked (WebDAV)            |                                     |
|                        |                             |                             | 424 Failed Dependency (WebDAV) |                                     |
|                        |                             |                             | 425 Too Early                  |                                     |
|                        |                             |                             | 426 Upgrade Required           |                                     |
|                        |                             |                             | 428 Precondition Required      |                                     |
|                        |                             |                             | 429 Too Many Requests          |                                     |
|                        |                             |                             | 431 Request Header Fields Large|                                     |
|                        |                             |                             | 451 Unavailable for Legal Reasons|                                    |
|                        |                             |                             | 499 Client Closed Request      |                                     |

