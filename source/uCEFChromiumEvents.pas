unit uCEFChromiumEvents;

{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}
{$ENDIF}

{$I cef.inc}

{$IFNDEF TARGET_64BITS}{$ALIGN ON}{$ENDIF}
{$MINENUMSIZE 4}

interface

uses
  {$IFDEF DELPHI16_UP}
  System.Classes, {$IFDEF MSWINDOWS}WinApi.Messages,{$ENDIF}
  {$ELSE}
  Classes, {$IFDEF MSWINDOWS}Messages,{$ENDIF}
  {$ENDIF}
  uCEFTypes, uCEFInterfaces;

type
  // ICefClient
  TOnProcessMessageReceived       = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; sourceProcess: TCefProcessId; const message: ICefProcessMessage; out Result: Boolean) of object;

  // ICefLoadHandler
  TOnLoadStart                    = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; transitionType: TCefTransitionType) of object;
  TOnLoadEnd                      = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer) of object;
  TOnLoadError                    = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; errorCode: TCefErrorCode; const errorText, failedUrl: ustring) of object;
  TOnLoadingStateChange           = procedure(Sender: TObject; const browser: ICefBrowser; isLoading, canGoBack, canGoForward: Boolean) of object;

  // ICefFocusHandler
  TOnTakeFocus                    = procedure(Sender: TObject; const browser: ICefBrowser; next_: Boolean) of object;
  TOnSetFocus                     = procedure(Sender: TObject; const browser: ICefBrowser; source: TCefFocusSource; out Result: Boolean) of object;
  TOnGotFocus                     = procedure(Sender: TObject; const browser: ICefBrowser) of object;

  // ICefContextMenuHandler
  TOnBeforeContextMenu            = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel) of object;
  TOnRunContextMenu               = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; const model: ICefMenuModel; const callback: ICefRunContextMenuCallback; var aResult : Boolean) of object;
  TOnContextMenuCommand           = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const params: ICefContextMenuParams; commandId: Integer; eventFlags: TCefEventFlags; out Result: Boolean) of object;
  TOnContextMenuDismissed         = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame) of object;
  TOnRunQuickMenuEvent            = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; location: TCefPoint; size: TCefSize; edit_state_flags: TCefQuickMenuEditStateFlags; const callback: ICefRunQuickMenuCallback; var aResult : Boolean) of object;
  TOnQuickMenuCommandEvent        = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; command_id: integer; event_flags: TCefEventFlags; var aResult: Boolean) of object;
  TOnQuickMenuDismissedEvent      = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame) of object;

  // ICefKeyboardHandler
  TOnPreKeyEvent                  = procedure(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: TCefEventHandle; out isKeyboardShortcut: Boolean; out Result: Boolean) of object;
  TOnKeyEvent                     = procedure(Sender: TObject; const browser: ICefBrowser; const event: PCefKeyEvent; osEvent: TCefEventHandle; out Result: Boolean) of object;

  // ICefDisplayHandler
  TOnAddressChange                = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const url: ustring) of object;
  TOnTitleChange                  = procedure(Sender: TObject; const browser: ICefBrowser; const title: ustring) of object;
  TOnFavIconUrlChange             = procedure(Sender: TObject; const browser: ICefBrowser; const iconUrls: TStrings) of object;
  TOnFullScreenModeChange         = procedure(Sender: TObject; const browser: ICefBrowser; fullscreen: Boolean) of object;
  TOnTooltip                      = procedure(Sender: TObject; const browser: ICefBrowser; var text: ustring; out Result: Boolean) of object;
  TOnStatusMessage                = procedure(Sender: TObject; const browser: ICefBrowser; const value: ustring) of object;
  TOnConsoleMessage               = procedure(Sender: TObject; const browser: ICefBrowser; level: TCefLogSeverity; const message, source: ustring; line: Integer; out Result: Boolean) of object;
  TOnAutoResize                   = procedure(Sender: TObject; const browser: ICefBrowser; const new_size: PCefSize; out Result: Boolean) of object;
  TOnLoadingProgressChange        = procedure(Sender: TObject; const browser: ICefBrowser; const progress: double) of object;
  TOnCursorChange                 = procedure(Sender: TObject; const browser: ICefBrowser; cursor_: TCefCursorHandle; cursorType: TCefCursorType; const customCursorInfo: PCefCursorInfo; var aResult : boolean) of Object;
  TOnMediaAccessChange            = procedure(Sender: TObject; const browser: ICefBrowser; has_video_access, has_audio_access: boolean) of Object;
  TOnContentsBoundsChange         = procedure(Sender: TObject; const browser: ICefBrowser; const new_bounds: PCefRect; var aResult : boolean) of Object;
  TOnGetRootWindowScreenRect      = procedure(Sender: TObject; const browser: ICefBrowser; rect_: PCefRect; var aResult : boolean) of Object;

  // ICefDownloadHandler
  TOnCanDownloadEvent             = procedure(Sender: TObject; const browser: ICefBrowser; const url, request_method: ustring; var aResult: boolean) of object;
  TOnBeforeDownload               = procedure(Sender: TObject; const browser: ICefBrowser; const downloadItem: ICefDownloadItem; const suggestedName: ustring; const callback: ICefBeforeDownloadCallback; var aResult : boolean) of object;
  TOnDownloadUpdated              = procedure(Sender: TObject; const browser: ICefBrowser; const downloadItem: ICefDownloadItem; const callback: ICefDownloadItemCallback) of object;

  // ICefJsDialogHandler
  TOnJsdialog                     = procedure(Sender: TObject; const browser: ICefBrowser; const originUrl: ustring; dialogType: TCefJsDialogType; const messageText, defaultPromptText: ustring; const callback: ICefJsDialogCallback; out suppressMessage: Boolean; out Result: Boolean) of object;
  TOnBeforeUnloadDialog           = procedure(Sender: TObject; const browser: ICefBrowser; const messageText: ustring; isReload: Boolean; const callback: ICefJsDialogCallback; out Result: Boolean) of object;
  TOnResetDialogState             = procedure(Sender: TObject; const browser: ICefBrowser) of object;
  TOnDialogClosed                 = procedure(Sender: TObject; const browser: ICefBrowser) of object;

  // ICefLifeSpanHandler
  TOnBeforePopup                  = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; popup_id: Integer; const targetUrl, targetFrameName: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; const popupFeatures: TCefPopupFeatures; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue; var noJavascriptAccess: Boolean; var Result: Boolean) of object;
  TOnBeforePopupAborted           = procedure(Sender: TObject; const browser: ICefBrowser; popup_id: Integer) of object;
  TOnBeforeDevToolsPopup          = procedure(Sender: TObject; const browser: ICefBrowser; var windowInfo: TCefWindowInfo; var client: ICefClient; var settings: TCefBrowserSettings; var extra_info: ICefDictionaryValue; var use_default_window: boolean) of object;
  TOnAfterCreated                 = procedure(Sender: TObject; const browser: ICefBrowser) of object;
  TOnBeforeClose                  = procedure(Sender: TObject; const browser: ICefBrowser) of object;
  TOnClose                        = procedure(Sender: TObject; const browser: ICefBrowser; var aAction : TCefCloseBrowserAction) of object;

  // ICefRequestHandler
  TOnBeforeBrowse                 = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; user_gesture, isRedirect: Boolean; out Result: Boolean) of object;
  TOnOpenUrlFromTab               = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const targetUrl: ustring; targetDisposition: TCefWindowOpenDisposition; userGesture: Boolean; out Result: Boolean) of object;
  TOnGetAuthCredentials           = procedure(Sender: TObject; const browser: ICefBrowser; const originUrl: ustring; isProxy: Boolean; const host: ustring; port: Integer; const realm, scheme: ustring; const callback: ICefAuthCallback; out Result: Boolean) of object;
  TOnCertificateError             = procedure(Sender: TObject; const browser: ICefBrowser; certError: TCefErrorcode; const requestUrl: ustring; const sslInfo: ICefSslInfo; const callback: ICefCallback; out Result: Boolean) of object;
  TOnSelectClientCertificate      = procedure(Sender: TObject; const browser: ICefBrowser; isProxy: boolean; const host: ustring; port: integer; certificatesCount: NativeUInt; const certificates: TCefX509CertificateArray; const callback: ICefSelectClientCertificateCallback; var aResult : boolean) of object;
  TOnRenderViewReady              = procedure(Sender: Tobject; const browser: ICefBrowser) of object;
  TOnRenderProcessUnresponsive    = procedure(Sender: Tobject; const browser: ICefBrowser; const callback: ICefUnresponsiveProcessCallback; var aResult: boolean) of object;
  TOnRenderProcessResponsive      = procedure(Sender: Tobject; const browser: ICefBrowser) of object;
  TOnRenderProcessTerminated      = procedure(Sender: TObject; const browser: ICefBrowser; status: TCefTerminationStatus; error_code: integer; const error_string: ustring) of object;
  TOnGetResourceRequestHandler    = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; is_navigation, is_download: boolean; const request_initiator: ustring; var disable_default_handling: boolean; var aExternalResourceRequestHandler : ICefResourceRequestHandler) of object;
  TOnDocumentAvailableInMainFrame = procedure(Sender: Tobject; const browser: ICefBrowser) of object;

  // ICefResourceRequestHandler
  TOnBeforeResourceLoad           = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const callback: ICefCallback; out Result: TCefReturnValue) of object;
  TOnGetResourceHandler           = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; var aResourceHandler : ICefResourceHandler) of object;
  TOnResourceRedirect             = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const response: ICefResponse; var newUrl: ustring) of object;
  TOnResourceResponse             = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const response: ICefResponse; out Result: Boolean) of Object;
  TOnGetResourceResponseFilter    = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const response: ICefResponse; out Result: ICefResponseFilter) of object;
  TOnResourceLoadComplete         = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const response: ICefResponse; status: TCefUrlRequestStatus; receivedContentLength: Int64) of object;
  TOnProtocolExecution            = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; var allowOsExecution: Boolean) of object;

  // ICefCookieAccessFilter
  TOnCanSendCookie                = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const cookie: PCefCookie; var aResult: boolean) of object;
  TOnCanSaveCookie                = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const request: ICefRequest; const response: ICefResponse; const cookie: PCefCookie; var aResult : boolean) of object;

  // ICefDialogHandler
  TOnFileDialog                   = procedure(Sender: TObject; const browser: ICefBrowser; mode: TCefFileDialogMode; const title, defaultFilePath: ustring; const acceptFilters, accept_extensions, accept_descriptions: TStrings; const callback: ICefFileDialogCallback; var Result: Boolean) of Object;

  // ICefRenderHandler
  TOnGetAccessibilityHandler      = procedure(Sender: TObject; var aAccessibilityHandler : ICefAccessibilityHandler) of Object;
  TOnGetRootScreenRect            = procedure(Sender: TObject; const browser: ICefBrowser; var rect: TCefRect; out Result: Boolean) of Object;
  TOnGetViewRect                  = procedure(Sender: TObject; const browser: ICefBrowser; var rect: TCefRect) of Object;
  TOnGetScreenPoint               = procedure(Sender: TObject; const browser: ICefBrowser; viewX, viewY: Integer; var screenX, screenY: Integer; out Result: Boolean) of Object;
  TOnGetScreenInfo                = procedure(Sender: TObject; const browser: ICefBrowser; var screenInfo: TCefScreenInfo; out Result: Boolean) of Object;
  TOnPopupShow                    = procedure(Sender: TObject; const browser: ICefBrowser; show: Boolean) of Object;
  TOnPopupSize                    = procedure(Sender: TObject; const browser: ICefBrowser; const rect: PCefRect) of Object;
  TOnPaint                        = procedure(Sender: TObject; const browser: ICefBrowser; type_: TCefPaintElementType; dirtyRectsCount: NativeUInt; const dirtyRects: PCefRectArray; const buffer: Pointer; width, height: Integer) of Object;
  TOnAcceleratedPaint             = procedure(Sender: TObject; const browser: ICefBrowser; type_: TCefPaintElementType; dirtyRectsCount: NativeUInt; const dirtyRects: PCefRectArray; const info: PCefAcceleratedPaintInfo) of Object;
  TOnGetTouchHandleSize           = procedure(Sender: TObject; const browser: ICefBrowser; orientation: TCefHorizontalAlignment; var size: TCefSize) of Object;
  TOnTouchHandleStateChanged      = procedure(Sender: TObject; const browser: ICefBrowser; const state: TCefTouchHandleState) of Object;
  TOnStartDragging                = procedure(Sender: TObject; const browser: ICefBrowser; const dragData: ICefDragData; allowedOps: TCefDragOperations; x, y: Integer; out Result: Boolean) of Object;
  TOnUpdateDragCursor             = procedure(Sender: TObject; const browser: ICefBrowser; operation: TCefDragOperation) of Object;
  TOnScrollOffsetChanged          = procedure(Sender: TObject; const browser: ICefBrowser; x, y: Double) of Object;
  TOnIMECompositionRangeChanged   = procedure(Sender: TObject; const browser: ICefBrowser; const selected_range: PCefRange; character_boundsCount: NativeUInt; const character_bounds: PCefRect) of Object;
  TOnTextSelectionChanged         = procedure(Sender: TObject; const browser: ICefBrowser; const selected_text: ustring; const selected_range: PCefRange) of Object;
  TOnVirtualKeyboardRequested     = procedure(Sender: TObject; const browser: ICefBrowser; input_mode: TCefTextInpuMode) of Object;

  // ICefDragHandler
  TOnDragEnter                    = procedure(Sender: TObject; const browser: ICefBrowser; const dragData: ICefDragData; mask: TCefDragOperations; out Result: Boolean) of Object;
  TOnDraggableRegionsChanged      = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; regionsCount: NativeUInt; const regions: PCefDraggableRegionArray) of Object;

  // ICefFindHandler
  TOnFindResult                   = procedure(Sender: TObject; const browser: ICefBrowser; identifier, count: Integer; const selectionRect: PCefRect; activeMatchOrdinal: Integer; finalUpdate: Boolean) of Object;

  // ICefRequestContextHandler
  TOnRequestContextInitialized    = procedure(Sender: TObject; const request_context: ICefRequestContext) of Object;
  // ICefRequestContextHandler uses the same TOnGetResourceRequestHandler event type defined for ICefRequestHandler

  // ICefMediaObserver
  TOnSinksEvent                   = procedure(Sender: TObject; const sinks: TCefMediaSinkArray) of object;
  TOnRoutesEvent                  = procedure(Sender: TObject; const routes: TCefMediaRouteArray) of object;
  TOnRouteStateChangedEvent       = procedure(Sender: TObject; const route: ICefMediaRoute; state: TCefMediaRouteConnectionState) of object;
  TOnRouteMessageReceivedEvent    = procedure(Sender: TObject; const route: ICefMediaRoute; const message_: ustring) of object;

  // ICefAudioHandler
  TOnGetAudioParametersEvent      = procedure(Sender: TObject; const browser: ICefBrowser; var params: TCefAudioParameters; var aResult: boolean) of object;
  TOnAudioStreamStartedEvent      = procedure(Sender: TObject; const browser: ICefBrowser; const params: TCefAudioParameters; channels: integer) of object;
  TOnAudioStreamPacketEvent       = procedure(Sender: TObject; const browser: ICefBrowser; const data : PPSingle; frames: integer; pts: int64) of object;
  TOnAudioStreamStoppedEvent      = procedure(Sender: TObject; const browser: ICefBrowser) of object;
  TOnAudioStreamErrorEvent        = procedure(Sender: TObject; const browser: ICefBrowser; const message_: ustring) of object;

  // ICefDevToolsMessageObserver
  TOnDevToolsMessageEvent         = procedure(Sender: TObject; const browser: ICefBrowser; const message_: ICefValue; var aHandled: boolean) of object;
  TOnDevToolsRawMessageEvent      = procedure(Sender: TObject; const browser: ICefBrowser; const message_: Pointer; message_size: NativeUInt; var aHandled: boolean) of object;
  TOnDevToolsMethodResultEvent    = procedure(Sender: TObject; const browser: ICefBrowser; message_id: integer; success: boolean; const result: ICefValue) of object;
  TOnDevToolsMethodRawResultEvent = procedure(Sender: TObject; const browser: ICefBrowser; message_id: integer; success: boolean; const result: Pointer; result_size: NativeUInt) of object;
  TOnDevToolsEventEvent           = procedure(Sender: TObject; const browser: ICefBrowser; const method: ustring; const params: ICefValue) of object;
  TOnDevToolsEventRawEvent        = procedure(Sender: TObject; const browser: ICefBrowser; const method: ustring; const params: Pointer; params_size: NativeUInt) of object;
  TOnDevToolsAgentAttachedEvent   = procedure(Sender: TObject; const browser: ICefBrowser) of object;
  TOnDevToolsAgentDetachedEvent   = procedure(Sender: TObject; const browser: ICefBrowser) of object;

  // ICefPrintHandler
  TOnPrintStartEvent              = procedure(Sender: TObject; const browser: ICefBrowser) of object;
  TOnPrintSettingsEvent           = procedure(Sender: TObject; const browser: ICefBrowser; const settings: ICefPrintSettings; getDefaults: boolean) of object;
  TOnPrintDialogEvent             = procedure(Sender: TObject; const browser: ICefBrowser; hasSelection: boolean; const callback: ICefPrintDialogCallback; var aResult : boolean) of object;
  TOnPrintJobEvent                = procedure(Sender: TObject; const browser: ICefBrowser; const documentName, PDFFilePath: ustring; const callback: ICefPrintJobCallback; var aResult : boolean) of object;
  TOnPrintResetEvent              = procedure(Sender: TObject; const browser: ICefBrowser) of object;
  TOnGetPDFPaperSizeEvent         = procedure(Sender: TObject; const browser: ICefBrowser; deviceUnitsPerInch: Integer; var aResult : TCefSize) of object;

  // ICefFrameHandler
  TOnFrameCreated                 = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame) of object;
  TOnFrameDestroyed               = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame) of object;
  TOnFrameAttached                = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; reattached: boolean) of object;
  TOnFrameDetached                = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame) of object;
  TOnMainFrameChanged             = procedure(Sender: TObject; const browser: ICefBrowser; const old_frame, new_frame: ICefFrame) of object;

  // ICefCommandHandler
  TOnChromeCommandEvent                  = procedure(Sender: TObject; const browser: ICefBrowser; command_id: integer; disposition: TCefWindowOpenDisposition; var aResult: boolean) of object;
  TOnIsChromeAppMenuItemVisibleEvent     = procedure(Sender: TObject; const browser: ICefBrowser; command_id: integer; var aResult: boolean) of object;
  TOnIsChromeAppMenuItemEnabledEvent     = procedure(Sender: TObject; const browser: ICefBrowser; command_id: integer; var aResult: boolean) of object;
  TOnIsChromePageActionIconVisibleEvent  = procedure(Sender: TObject; icon_type: TCefChromePageActionIconType; var aResult: boolean) of object;
  TOnIsChromeToolbarButtonVisibleEvent   = procedure(Sender: TObject; button_type: TCefChromeToolbarButtonType; var aResult: boolean) of object;

  // ICefPermissionHandler
  TOnRequestMediaAccessPermissionEvent = procedure(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; const requesting_origin: ustring; requested_permissions: cardinal; const callback: ICefMediaAccessCallback; var aResult: boolean) of object;
  TOnShowPermissionPromptEvent         = procedure(Sender: TObject; const browser: ICefBrowser; prompt_id: uint64; const requesting_origin: ustring; requested_permissions: cardinal; const callback: ICefPermissionPromptCallback; var aResult: boolean) of object;
  TOnDismissPermissionPromptEvent      = procedure(Sender: TObject; const browser: ICefBrowser; prompt_id: uint64; result: TCefPermissionRequestResult) of object;

  // ICefPreferenceObserver
  TOnPreferenceChangedEvent            = procedure(Sender: TObject; const name_: ustring) of object;

  // ICefSettingObserver
  TOnSettingChangedEvent               = procedure(Sender: TObject; const requesting_url, top_level_url : ustring; content_type: TCefContentSettingTypes) of object;

  // Custom
  TOnTextResultAvailableEvent              = procedure(Sender: TObject; const aText : ustring) of object;
  TOnPdfPrintFinishedEvent                 = procedure(Sender: TObject; aResultOK : boolean) of object;
  TOnPrefsAvailableEvent                   = procedure(Sender: TObject; aResultOK : boolean) of object;
  TOnCookiesDeletedEvent                   = procedure(Sender: TObject; numDeleted : integer) of object;
  TOnResolvedIPsAvailableEvent             = procedure(Sender: TObject; result: TCefErrorCode; const resolvedIps: TStrings) of object;
  TOnNavigationVisitorResultAvailableEvent = procedure(Sender: TObject; const entry: ICefNavigationEntry; current: Boolean; index, total: Integer; var aResult : boolean) of object;
  TOnDownloadImageFinishedEvent            = procedure(Sender: TObject; const imageUrl: ustring; httpStatusCode: Integer; const image: ICefImage) of object;
  TOnExecuteTaskOnCefThread                = procedure(Sender: TObject; aTaskID : cardinal) of object;
  TOnCookiesVisited                        = procedure(Sender: TObject; const name_, value, domain, path: ustring; secure, httponly, hasExpires: Boolean; const creation, lastAccess, expires: TDateTime; count, total, aID : Integer; same_site : TCefCookieSameSite; priority : TCefCookiePriority; var aDeleteCookie, aResult : Boolean) of object;
  TOnCookieVisitorDestroyed                = procedure(Sender: TObject; aID : integer) of object;
  TOnCookieSet                             = procedure(Sender: TObject; aSuccess : boolean; aID : integer) of object;
  TOnZoomPctAvailable                      = procedure(Sender: TObject; const aZoomPct : double) of object;
  TOnMediaRouteCreateFinishedEvent         = procedure(Sender: TObject; result: TCefMediaRouterCreateResult; const error: ustring; const route: ICefMediaRoute) of object;
  TOnMediaSinkDeviceInfoEvent              = procedure(Sender: TObject; const ip_address: ustring; port: integer; const model_name: ustring) of object;
  {$IFDEF MSWINDOWS}
  TOnCompMsgEvent                          = procedure(Sender: TObject; var aMessage: TMessage; var aHandled: Boolean) of object;
  {$ENDIF}

implementation

end.
