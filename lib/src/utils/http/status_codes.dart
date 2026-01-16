/// VelocityUI HTTP 状态码管理
/// 提供 HTTP 状态码常量和描述信息
library velocity_http_status_codes;

/// HTTP 状态码管理类
/// 提供状态码常量、描述信息和分类方法
class HttpStatusCodes {
  HttpStatusCodes._();

  // ==================== 1xx 信息性状态码 ====================

  /// 100 Continue - 继续
  static const int continue_ = 100;

  /// 101 Switching Protocols - 切换协议
  static const int switchingProtocols = 101;

  /// 102 Processing - 处理中 (WebDAV)
  static const int processing = 102;

  /// 103 Early Hints - 早期提示
  static const int earlyHints = 103;

  // ==================== 2xx 成功状态码 ====================

  /// 200 OK - 成功
  static const int ok = 200;

  /// 201 Created - 已创建
  static const int created = 201;

  /// 202 Accepted - 已接受
  static const int accepted = 202;

  /// 203 Non-Authoritative Information - 非权威信息
  static const int nonAuthoritativeInformation = 203;

  /// 204 No Content - 无内容
  static const int noContent = 204;

  /// 205 Reset Content - 重置内容
  static const int resetContent = 205;

  /// 206 Partial Content - 部分内容
  static const int partialContent = 206;

  /// 207 Multi-Status - 多状态 (WebDAV)
  static const int multiStatus = 207;

  /// 208 Already Reported - 已报告 (WebDAV)
  static const int alreadyReported = 208;

  /// 226 IM Used - IM 已使用
  static const int imUsed = 226;

  // ==================== 3xx 重定向状态码 ====================

  /// 300 Multiple Choices - 多种选择
  static const int multipleChoices = 300;

  /// 301 Moved Permanently - 永久移动
  static const int movedPermanently = 301;

  /// 302 Found - 临时移动
  static const int found = 302;

  /// 303 See Other - 查看其他
  static const int seeOther = 303;

  /// 304 Not Modified - 未修改
  static const int notModified = 304;

  /// 305 Use Proxy - 使用代理
  static const int useProxy = 305;

  /// 307 Temporary Redirect - 临时重定向
  static const int temporaryRedirect = 307;

  /// 308 Permanent Redirect - 永久重定向
  static const int permanentRedirect = 308;

  // ==================== 4xx 客户端错误状态码 ====================

  /// 400 Bad Request - 错误请求
  static const int badRequest = 400;

  /// 401 Unauthorized - 未授权
  static const int unauthorized = 401;

  /// 402 Payment Required - 需要付款
  static const int paymentRequired = 402;

  /// 403 Forbidden - 禁止访问
  static const int forbidden = 403;

  /// 404 Not Found - 未找到
  static const int notFound = 404;

  /// 405 Method Not Allowed - 方法不允许
  static const int methodNotAllowed = 405;

  /// 406 Not Acceptable - 不可接受
  static const int notAcceptable = 406;

  /// 407 Proxy Authentication Required - 需要代理认证
  static const int proxyAuthenticationRequired = 407;

  /// 408 Request Timeout - 请求超时
  static const int requestTimeout = 408;

  /// 409 Conflict - 冲突
  static const int conflict = 409;

  /// 410 Gone - 已删除
  static const int gone = 410;

  /// 411 Length Required - 需要内容长度
  static const int lengthRequired = 411;

  /// 412 Precondition Failed - 前提条件失败
  static const int preconditionFailed = 412;

  /// 413 Payload Too Large - 请求体过大
  static const int payloadTooLarge = 413;

  /// 414 URI Too Long - URI 过长
  static const int uriTooLong = 414;

  /// 415 Unsupported Media Type - 不支持的媒体类型
  static const int unsupportedMediaType = 415;

  /// 416 Range Not Satisfiable - 范围不满足
  static const int rangeNotSatisfiable = 416;

  /// 417 Expectation Failed - 期望失败
  static const int expectationFailed = 417;

  /// 418 I'm a teapot - 我是茶壶 (彩蛋)
  static const int imATeapot = 418;

  /// 421 Misdirected Request - 错误定向的请求
  static const int misdirectedRequest = 421;

  /// 422 Unprocessable Entity - 无法处理的实体 (WebDAV)
  static const int unprocessableEntity = 422;

  /// 423 Locked - 已锁定 (WebDAV)
  static const int locked = 423;

  /// 424 Failed Dependency - 依赖失败 (WebDAV)
  static const int failedDependency = 424;

  /// 425 Too Early - 太早
  static const int tooEarly = 425;

  /// 426 Upgrade Required - 需要升级
  static const int upgradeRequired = 426;

  /// 428 Precondition Required - 需要前提条件
  static const int preconditionRequired = 428;

  /// 429 Too Many Requests - 请求过多
  static const int tooManyRequests = 429;

  /// 431 Request Header Fields Too Large - 请求头字段过大
  static const int requestHeaderFieldsTooLarge = 431;

  /// 451 Unavailable For Legal Reasons - 因法律原因不可用
  static const int unavailableForLegalReasons = 451;

  // ==================== 5xx 服务器错误状态码 ====================

  /// 500 Internal Server Error - 服务器内部错误
  static const int internalServerError = 500;

  /// 501 Not Implemented - 未实现
  static const int notImplemented = 501;

  /// 502 Bad Gateway - 网关错误
  static const int badGateway = 502;

  /// 503 Service Unavailable - 服务不可用
  static const int serviceUnavailable = 503;

  /// 504 Gateway Timeout - 网关超时
  static const int gatewayTimeout = 504;

  /// 505 HTTP Version Not Supported - HTTP 版本不支持
  static const int httpVersionNotSupported = 505;

  /// 506 Variant Also Negotiates - 变体协商
  static const int variantAlsoNegotiates = 506;

  /// 507 Insufficient Storage - 存储空间不足 (WebDAV)
  static const int insufficientStorage = 507;

  /// 508 Loop Detected - 检测到循环 (WebDAV)
  static const int loopDetected = 508;

  /// 510 Not Extended - 未扩展
  static const int notExtended = 510;

  /// 511 Network Authentication Required - 需要网络认证
  static const int networkAuthenticationRequired = 511;

  // ==================== 状态码描述映射 ====================

  /// 状态码到描述信息的映射
  static const Map<int, String> messages = {
    // 1xx
    100: '继续',
    101: '切换协议',
    102: '处理中',
    103: '早期提示',
    // 2xx
    200: '成功',
    201: '已创建',
    202: '已接受',
    203: '非权威信息',
    204: '无内容',
    205: '重置内容',
    206: '部分内容',
    207: '多状态',
    208: '已报告',
    226: 'IM 已使用',
    // 3xx
    300: '多种选择',
    301: '永久移动',
    302: '临时移动',
    303: '查看其他',
    304: '未修改',
    305: '使用代理',
    307: '临时重定向',
    308: '永久重定向',
    // 4xx
    400: '错误请求',
    401: '未授权',
    402: '需要付款',
    403: '禁止访问',
    404: '未找到',
    405: '方法不允许',
    406: '不可接受',
    407: '需要代理认证',
    408: '请求超时',
    409: '冲突',
    410: '已删除',
    411: '需要内容长度',
    412: '前提条件失败',
    413: '请求体过大',
    414: 'URI 过长',
    415: '不支持的媒体类型',
    416: '范围不满足',
    417: '期望失败',
    418: '我是茶壶',
    421: '错误定向的请求',
    422: '无法处理的实体',
    423: '已锁定',
    424: '依赖失败',
    425: '太早',
    426: '需要升级',
    428: '需要前提条件',
    429: '请求过多',
    431: '请求头字段过大',
    451: '因法律原因不可用',
    // 5xx
    500: '服务器内部错误',
    501: '未实现',
    502: '网关错误',
    503: '服务不可用',
    504: '网关超时',
    505: 'HTTP 版本不支持',
    506: '变体协商',
    507: '存储空间不足',
    508: '检测到循环',
    510: '未扩展',
    511: '需要网络认证',
  };

  /// 英文状态码描述映射
  static const Map<int, String> messagesEn = {
    // 1xx
    100: 'Continue',
    101: 'Switching Protocols',
    102: 'Processing',
    103: 'Early Hints',
    // 2xx
    200: 'OK',
    201: 'Created',
    202: 'Accepted',
    203: 'Non-Authoritative Information',
    204: 'No Content',
    205: 'Reset Content',
    206: 'Partial Content',
    207: 'Multi-Status',
    208: 'Already Reported',
    226: 'IM Used',
    // 3xx
    300: 'Multiple Choices',
    301: 'Moved Permanently',
    302: 'Found',
    303: 'See Other',
    304: 'Not Modified',
    305: 'Use Proxy',
    307: 'Temporary Redirect',
    308: 'Permanent Redirect',
    // 4xx
    400: 'Bad Request',
    401: 'Unauthorized',
    402: 'Payment Required',
    403: 'Forbidden',
    404: 'Not Found',
    405: 'Method Not Allowed',
    406: 'Not Acceptable',
    407: 'Proxy Authentication Required',
    408: 'Request Timeout',
    409: 'Conflict',
    410: 'Gone',
    411: 'Length Required',
    412: 'Precondition Failed',
    413: 'Payload Too Large',
    414: 'URI Too Long',
    415: 'Unsupported Media Type',
    416: 'Range Not Satisfiable',
    417: 'Expectation Failed',
    418: "I'm a teapot",
    421: 'Misdirected Request',
    422: 'Unprocessable Entity',
    423: 'Locked',
    424: 'Failed Dependency',
    425: 'Too Early',
    426: 'Upgrade Required',
    428: 'Precondition Required',
    429: 'Too Many Requests',
    431: 'Request Header Fields Too Large',
    451: 'Unavailable For Legal Reasons',
    // 5xx
    500: 'Internal Server Error',
    501: 'Not Implemented',
    502: 'Bad Gateway',
    503: 'Service Unavailable',
    504: 'Gateway Timeout',
    505: 'HTTP Version Not Supported',
    506: 'Variant Also Negotiates',
    507: 'Insufficient Storage',
    508: 'Loop Detected',
    510: 'Not Extended',
    511: 'Network Authentication Required',
  };

  /// 获取状态码描述信息（中文）
  static String getMessage(int code) => messages[code] ?? '未知错误';

  /// 获取状态码描述信息（英文）
  static String getMessageEn(int code) => messagesEn[code] ?? 'Unknown Error';

  /// 获取状态码描述信息（根据语言）
  static String getMessageByLocale(int code, {bool english = false}) =>
      english ? getMessageEn(code) : getMessage(code);

  /// 判断是否为信息性状态码 (1xx)
  static bool isInformational(int code) => code >= 100 && code < 200;

  /// 判断是否为成功状态码 (2xx)
  static bool isSuccess(int code) => code >= 200 && code < 300;

  /// 判断是否为重定向状态码 (3xx)
  static bool isRedirection(int code) => code >= 300 && code < 400;

  /// 判断是否为客户端错误状态码 (4xx)
  static bool isClientError(int code) => code >= 400 && code < 500;

  /// 判断是否为服务器错误状态码 (5xx)
  static bool isServerError(int code) => code >= 500 && code < 600;

  /// 判断是否为错误状态码 (4xx 或 5xx)
  static bool isError(int code) => code >= 400;

  /// 获取状态码类别
  static StatusCodeCategory getCategory(int code) {
    if (isInformational(code)) return StatusCodeCategory.informational;
    if (isSuccess(code)) return StatusCodeCategory.success;
    if (isRedirection(code)) return StatusCodeCategory.redirection;
    if (isClientError(code)) return StatusCodeCategory.clientError;
    if (isServerError(code)) return StatusCodeCategory.serverError;
    return StatusCodeCategory.unknown;
  }
}

/// 状态码类别枚举
enum StatusCodeCategory {
  /// 信息性 (1xx)
  informational,

  /// 成功 (2xx)
  success,

  /// 重定向 (3xx)
  redirection,

  /// 客户端错误 (4xx)
  clientError,

  /// 服务器错误 (5xx)
  serverError,

  /// 未知
  unknown,
}
