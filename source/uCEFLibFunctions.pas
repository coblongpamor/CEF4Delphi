unit uCEFLibFunctions;

{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}
{$ENDIF}

{$I cef.inc}

{$IFNDEF TARGET_64BITS}{$ALIGN ON}{$ENDIF}
{$MINENUMSIZE 4}

interface

uses
  {$IFDEF DELPHI16_UP}
    {$IFDEF MSWINDOWS}WinApi.Windows,{$ENDIF} System.Math,
  {$ELSE}
    {$IFDEF MSWINDOWS}Windows,{$ENDIF} Math,
  {$ENDIF}
  {$IFDEF LINUX}
    {$IFDEF FPC}xlib,{$ENDIF}
    {$IFDEF FMX}uCEFLinuxTypes,{$ENDIF}
  {$ENDIF}
  uCEFTypes;

var
  // *********************************
  // ************ INCLUDE ************
  // *********************************

  // /include/cef_api_hash.h
  cef_api_hash               : function(version, entry: integer): PAnsiChar; cdecl;
  cef_api_version            : function : integer; cdecl;

  // /include/cef_version_info.h
  cef_version_info           : function(entry: integer) : integer; cdecl;
  cef_version_info_all       : procedure(info: PCefVersionInfoEx); cdecl;   {* CEF_API_ADDED(13800) *}

  // /include/cef_id_mappers.h
  cef_id_for_pack_resource_name : function(const name : PAnsiChar) : integer; cdecl;
  cef_id_for_pack_string_name   : function(const name : PAnsiChar) : integer; cdecl;
  cef_id_for_command_id_name    : function(const name : PAnsiChar) : integer; cdecl;


  // *********************************
  // ************* CAPI **************
  // *********************************

  // /include/capi/cef_app_capi.h
  cef_initialize             : function(const args: PCefMainArgs; const settings: PCefSettings; application: PCefApp; windows_sandbox_info: Pointer): Integer; cdecl;
  cef_get_exit_code          : function : integer; cdecl;
  cef_shutdown               : procedure; cdecl;
  cef_execute_process        : function(const args: PCefMainArgs; application: PCefApp; windows_sandbox_info: Pointer): Integer; cdecl;
  cef_do_message_loop_work   : procedure; cdecl;
  cef_run_message_loop       : procedure; cdecl;
  cef_quit_message_loop      : procedure; cdecl;

  // /include/capi/cef_browser_capi.h
  cef_browser_host_create_browser            : function(const windowInfo: PCefWindowInfo; client: PCefClient; const url: PCefString; const settings: PCefBrowserSettings; extra_info: PCefDictionaryValue; request_context: PCefRequestContext): Integer; cdecl;
  cef_browser_host_create_browser_sync       : function(const windowInfo: PCefWindowInfo; client: PCefClient; const url: PCefString; const settings: PCefBrowserSettings; extra_info: PCefDictionaryValue; request_context: PCefRequestContext): PCefBrowser; cdecl;
  cef_browser_host_get_browser_by_identifier : function(browser_id: Integer): PCefBrowser; cdecl;

  // /include/capi/cef_command_line_capi.h
  cef_command_line_create     : function : PCefCommandLine; cdecl;
  cef_command_line_get_global : function : PCefCommandLine; cdecl;

  // /include/capi/cef_cookie_capi.h
  cef_cookie_manager_get_global_manager   : function(callback: PCefCompletionCallback): PCefCookieManager; cdecl;

  // /include/capi/cef_crash_util.h
  cef_crash_reporting_enabled : function : integer; cdecl;
  cef_set_crash_key_value     : procedure(const key, value : PCefString); cdecl;

  // /include/capi/cef_drag_data_capi.h
  cef_drag_data_create : function : PCefDragData; cdecl;

  // /include/capi/cef_file_util_capi.h
  cef_create_directory                   : function(const full_path : PCefString): Integer; cdecl;
  cef_get_temp_directory                 : function(temp_dir : PCefString): Integer; cdecl;
  cef_create_new_temp_directory          : function(const prefix : PCefString; new_temp_path: PCefString): Integer; cdecl;
  cef_create_temp_directory_in_directory : function(const base_dir, prefix : PCefString; new_dir : PCefString): Integer; cdecl;
  cef_directory_exists                   : function(const path : PCefString): Integer; cdecl;
  cef_delete_file                        : function(const path : PCefString; recursive : integer): Integer; cdecl;
  cef_zip_directory                      : function(const src_dir, dest_file : PCefString; include_hidden_files : integer): Integer; cdecl;
  cef_load_crlsets_file                  : procedure(const path : PCefString); cdecl;

  // / include/capi/cef_i18n_util_capi.h
  cef_is_rtl                             : function : Integer; cdecl;

  // /include/capi/cef_image_capi.h
  cef_image_create : function : PCefImage; cdecl;

  // /include/capi/cef_media_router_capi.h
  cef_media_router_get_global : function(callback: PCefCompletionCallback) : PCefMediaRouter; cdecl;

  // /include/capi/cef_menu_model_capi.h
  cef_menu_model_create : function(delegate: PCefMenuModelDelegate): PCefMenuModel; cdecl;

  // /include/capi/cef_origin_whitelist_capi.h
  cef_add_cross_origin_whitelist_entry    : function(const source_origin, target_protocol, target_domain: PCefString; allow_target_subdomains: Integer): Integer; cdecl;
  cef_remove_cross_origin_whitelist_entry : function(const source_origin, target_protocol, target_domain: PCefString; allow_target_subdomains: Integer): Integer; cdecl;
  cef_clear_cross_origin_whitelist        : function : Integer; cdecl;

  // /include/capi/cef_parser_capi.h
  cef_resolve_url                     : function(const base_url, relative_url: PCefString; resolved_url: PCefString): Integer; cdecl;
  cef_parse_url                       : function(const url: PCefString; var parts: TCefUrlParts): Integer; cdecl;
  cef_create_url                      : function(const parts: PCefUrlParts; url: PCefString): Integer; cdecl;
  cef_format_url_for_security_display : function(const origin_url: PCefString): PCefStringUserFree; cdecl;
  cef_get_mime_type                   : function(const extension: PCefString): PCefStringUserFree; cdecl;
  cef_get_extensions_for_mime_type    : procedure(const mime_type: PCefString; extensions: TCefStringList); cdecl;
  cef_base64_encode                   : function(const data: Pointer; data_size: NativeUInt): PCefStringUserFree; cdecl;
  cef_base64_decode                   : function(const data: PCefString): PCefBinaryValue; cdecl;
  cef_uriencode                       : function(const text: PCefString; use_plus: Integer): PCefStringUserFree; cdecl;
  cef_uridecode                       : function(const text: PCefString; convert_to_utf8: Integer; unescape_rule: TCefUriUnescapeRule): PCefStringUserFree; cdecl;
  cef_parse_json                      : function(const json_string: PCefString; options: TCefJsonParserOptions): PCefValue; cdecl;
  cef_parse_json_buffer               : function(const json: Pointer; json_size: NativeUInt; options: TCefJsonParserOptions): PCefValue; cdecl;
  cef_parse_jsonand_return_error      : function(const json_string: PCefString; options: TCefJsonParserOptions; error_msg_out: PCefString): PCefValue; cdecl;
  cef_write_json                      : function(node: PCefValue; options: TCefJsonWriterOptions): PCefStringUserFree; cdecl;

  // /include/capi/cef_path_util_capi.h
  cef_get_path : function(key: TCefPathKey; path: PCefString): Integer; cdecl;

  // /include/capi/cef_preference_capi.h
  cef_preference_manager_get_global                          : function : PCefPreferenceManager; cdecl;
  cef_preference_manager_get_chrome_variations_as_switches   : procedure(switches: TCefStringList); cdecl;  {* CEF_API_ADDED(13401) *}
  cef_preference_manager_get_chrome_variations_as_strings    : procedure(strings: TCefStringList); cdecl;   {* CEF_API_ADDED(13401) *}

  // /include/capi/cef_print_settings_capi.h
  cef_print_settings_create : function : PCefPrintSettings; cdecl;

  // /include/capi/cef_process_message_capi.h
  cef_process_message_create : function(const name: PCefString): PCefProcessMessage; cdecl;

  // /include/capi/cef_process_util_capi.h
  cef_launch_process : function(command_line: PCefCommandLine): Integer; cdecl;

  // /include/capi/cef_request_capi.h
  cef_request_create           : function : PCefRequest; cdecl;
  cef_post_data_create         : function : PCefPostData; cdecl;
  cef_post_data_element_create : function : PCefPostDataElement; cdecl;

  // /include/capi/cef_request_context_capi.h
  cef_request_context_get_global_context        : function : PCefRequestContext; cdecl;
  cef_request_context_create_context            : function(const settings: PCefRequestContextSettings; handler: PCefRequestContextHandler): PCefRequestContext; cdecl;
  cef_request_context_cef_create_context_shared : function(other: PCefRequestContext; handler: PCefRequestContextHandler): PCefRequestContext; cdecl;

  // /include/capi/cef_resource_bundle_capi.h
  cef_resource_bundle_get_global : function : PCefResourceBundle; cdecl;

  // /include/capi/cef_response_capi.h
  cef_response_create : function : PCefResponse; cdecl;

  // /include/capi/cef_scheme_capi.h
  cef_register_scheme_handler_factory : function(const scheme_name, domain_name: PCefString; factory: PCefSchemeHandlerFactory): Integer; cdecl;
  cef_clear_scheme_handler_factories  : function : Integer; cdecl;

  // /include/capi/cef_server_capi.h
  cef_server_create : procedure(const address: PCefString; port: uint16; backlog: Integer; handler: PCefServerHandler); cdecl;

  // /include/capi/cef_shared_process_message_builder_capi.h
  cef_shared_process_message_builder_create : function(const name: PCefString; byte_size: NativeUInt) : PCefSharedProcessMessageBuilder; cdecl;

  // /include/capi/cef_ssl_info_capi.h
  cef_is_cert_status_error       : function(status : TCefCertStatus) : integer; cdecl;

  // /include/capi/cef_stream_capi.h
  cef_stream_reader_create_for_file    : function(const fileName: PCefString): PCefStreamReader; cdecl;
  cef_stream_reader_create_for_data    : function(data: Pointer; size: NativeUInt): PCefStreamReader; cdecl;
  cef_stream_reader_create_for_handler : function(handler: PCefReadHandler): PCefStreamReader; cdecl;
  cef_stream_writer_create_for_file    : function(const fileName: PCefString): PCefStreamWriter; cdecl;
  cef_stream_writer_create_for_handler : function(handler: PCefWriteHandler): PCefStreamWriter; cdecl;

  // /include/capi/cef_task_capi.h
  cef_task_runner_get_for_current_thread : function : PCefTaskRunner; cdecl;
  cef_task_runner_get_for_thread         : function(threadId: TCefThreadId): PCefTaskRunner; cdecl;
  cef_currently_on                       : function(threadId: TCefThreadId): Integer; cdecl;
  cef_post_task                          : function(threadId: TCefThreadId; task: PCefTask): Integer; cdecl;
  cef_post_delayed_task                  : function(threadId: TCefThreadId; task: PCefTask; delay_ms: Int64): Integer; cdecl;

  // /include/capi/cef_task_manager_capi.h
  cef_task_manager_get                   : function : PCefTaskManager;

  // /include/capi/cef_thread_capi.h
  cef_thread_create : function(const display_name: PCefString; priority: TCefThreadPriority; message_loop_type: TCefMessageLoopType; stoppable: integer; com_init_mode: TCefCOMInitMode): PCefThread; cdecl;

  // /include/capi/cef_trace_capi.h
  cef_begin_tracing              : function(const categories: PCefString; callback: PCefCompletionCallback): Integer; cdecl;
  cef_end_tracing                : function(const tracing_file: PCefString; callback: PCefEndTracingCallback): Integer; cdecl;
  cef_now_from_system_trace_time : function : int64; cdecl;

  // /include/capi/cef_urlrequest_capi.h
  cef_urlrequest_create : function(request: PCefRequest; client: PCefUrlRequestClient; request_context: PCefRequestContext): PCefUrlRequest; cdecl;

  // /include/capi/cef_v8_capi.h
  cef_v8_context_get_current_context         : function : PCefv8Context; cdecl;
  cef_v8_context_get_entered_context         : function : PCefv8Context; cdecl;
  cef_v8_context_in_context                  : function : Integer; cdecl;
  cef_v8_value_create_undefined              : function : PCefv8Value; cdecl;
  cef_v8_value_create_null                   : function : PCefv8Value; cdecl;
  cef_v8_value_create_bool                   : function(value: Integer): PCefv8Value; cdecl;
  cef_v8_value_create_int                    : function(value: Integer): PCefv8Value; cdecl;
  cef_v8_value_create_uint                   : function(value: Cardinal): PCefv8Value; cdecl;
  cef_v8_value_create_double                 : function(value: Double): PCefv8Value; cdecl;
  cef_v8_value_create_date                   : function(value: TCefBaseTime): PCefv8Value; cdecl;
  cef_v8_value_create_string                 : function(const value: PCefString): PCefv8Value; cdecl;
  cef_v8_value_create_object                 : function(accessor: PCefV8Accessor; interceptor: PCefV8Interceptor): PCefv8Value; cdecl;
  cef_v8_value_create_array                  : function(length: Integer): PCefv8Value; cdecl;
  cef_v8_value_create_array_buffer           : function(buffer : Pointer; length: NativeUInt; release_callback : PCefv8ArrayBufferReleaseCallback): PCefv8Value; cdecl;
  cef_v8_value_create_array_buffer_with_copy : function(buffer : Pointer; length: NativeUInt): PCefv8Value; cdecl;
  cef_v8_value_create_function               : function(const name: PCefString; handler: PCefv8Handler): PCefv8Value; cdecl;
  cef_v8_value_create_promise                : function : PCefv8Value; cdecl;
  cef_v8_stack_trace_get_current             : function(frame_limit: Integer): PCefV8StackTrace; cdecl;
  cef_register_extension                     : function(const extension_name, javascript_code: PCefString; handler: PCefv8Handler): Integer; cdecl;

  // /include/capi/cef_values_capi.h
  cef_value_create            : function : PCefValue; cdecl;
  cef_binary_value_create     : function(const data: Pointer; data_size: NativeUInt): PCefBinaryValue; cdecl;
  cef_dictionary_value_create : function : PCefDictionaryValue; cdecl;
  cef_list_value_create       : function : PCefListValue; cdecl;

  // /include/capi/cef_waitable_event_capi.h
  cef_waitable_event_create : function(automatic_reset, initially_signaled : integer): PCefWaitableEvent; cdecl;

  // /include/capi/cef_xml_reader_capi.h
  cef_xml_reader_create : function(stream: PCefStreamReader; encodingType: TCefXmlEncodingType; const URI: PCefString): PCefXmlReader; cdecl;

  // /include/capi/cef_zip_reader_capi.h
  cef_zip_reader_create : function(stream: PCefStreamReader): PCefZipReader; cdecl;



  // *********************************
  // ********** CAPI VIEWS ***********
  // *********************************

  // /include/capi/views/cef_browser_view_capi.h
  cef_browser_view_create          : function(client: PCefClient; const url: PCefString; const settings: PCefBrowserSettings; extra_info: PCefDictionaryValue; request_context: PCefRequestContext; delegate: PCefBrowserViewDelegate): PCefBrowserView; cdecl;
  cef_browser_view_get_for_browser : function(browser: PCefBrowser): PCefBrowserView; cdecl;

  // /include/capi/views/cef_display_capi.h
  cef_display_get_primary                      : function : PCefDisplay; cdecl;
  cef_display_get_nearest_point                : function(const point: PCefPoint; input_pixel_coords: Integer): PCefDisplay; cdecl;
  cef_display_get_matching_bounds              : function(const bounds: PCefRect; input_pixel_coords: Integer): PCefDisplay; cdecl;
  cef_display_get_count                        : function : NativeUInt; cdecl;
  cef_display_get_alls                         : procedure(displaysCount: PNativeUInt; displays: PPCefDisplay); cdecl;
  cef_display_convert_screen_point_to_pixels   : function(const point: PCefPoint): TCefPoint; cdecl;
  cef_display_convert_screen_point_from_pixels : function(const point: PCefPoint): TCefPoint; cdecl;
  cef_display_convert_screen_rect_to_pixels    : function(const rect: PCefRect): TCefRect; cdecl;
  cef_display_convert_screen_rect_from_pixels  : function(const rect: PCefRect): TCefRect; cdecl;

  // /include/capi/views/cef_label_button_capi.h
  cef_label_button_create         : function(delegate: PCefButtonDelegate; const text: PCefString): PCefLabelButton; cdecl;

  // /include/capi/views/cef_menu_button_capi.h
  cef_menu_button_create          : function(delegate: PCefMenuButtonDelegate; const text: PCefString): PCefMenuButton; cdecl;

  // /include/capi/views/cef_panel_capi.h
  cef_panel_create                : function(delegate: PCefPanelDelegate): PCefPanel; cdecl;

  // /include/capi/views/cef_scroll_view_capi.h
  cef_scroll_view_create          : function(delegate: PCefViewDelegate): PCefScrollView; cdecl;

  // /include/capi/views/cef_textfield_capi.h
  cef_textfield_create            : function(delegate: PCefTextfieldDelegate): PCefTextfield; cdecl;

  // /include/capi/views/cef_window_capi.h
  cef_window_create_top_level     : function(delegate: PCefWindowDelegate): PCefWindow; cdecl;



  // *********************************
  // *********** INTERNAL ************
  // *********************************

  // /include/internal/cef_app_win.h
  cef_set_osmodal_loop       : procedure(osModalLoop: Integer); cdecl;

  // /include/internal/cef_dump_without_crashing_internal.h
  cef_dump_without_crashing             : function(mseconds_between_dumps: int64; const function_name, file_name: PAnsiChar; line_number: integer): Integer; cdecl;

  // /include/internal/cef_logging_internal.h
  cef_get_min_log_level : function : Integer; cdecl;
  cef_get_vlog_level    : function(const file_start: PAnsiChar; N: NativeUInt): Integer; cdecl;
  cef_log               : procedure(const file_: PAnsiChar; line, severity: Integer; const message_: PAnsiChar); cdecl;

  // /include/internal/cef_string_list.h
  cef_string_list_alloc  : function : TCefStringList; cdecl;
  cef_string_list_size   : function(list: TCefStringList): NativeUInt; cdecl;
  cef_string_list_value  : function(list: TCefStringList; index: NativeUInt; value: PCefString): Integer; cdecl;
  cef_string_list_append : procedure(list: TCefStringList; const value: PCefString); cdecl;
  cef_string_list_clear  : procedure(list: TCefStringList); cdecl;
  cef_string_list_free   : procedure(list: TCefStringList); cdecl;
  cef_string_list_copy   : function(list: TCefStringList): TCefStringList; cdecl;

  // /include/internal/cef_string_map.h
  cef_string_map_alloc  : function : TCefStringMap; cdecl;
  cef_string_map_size   : function(map: TCefStringMap): NativeUInt; cdecl;
  cef_string_map_find   : function(map: TCefStringMap; const key: PCefString; value: PCefString): Integer; cdecl;
  cef_string_map_key    : function(map: TCefStringMap; index: NativeUInt; key: PCefString): Integer; cdecl;
  cef_string_map_value  : function(map: TCefStringMap; index: NativeUInt; value: PCefString): Integer; cdecl;
  cef_string_map_append : function(map: TCefStringMap; const key, value: PCefString): Integer; cdecl;
  cef_string_map_clear  : procedure(map: TCefStringMap); cdecl;
  cef_string_map_free   : procedure(map: TCefStringMap); cdecl;

  // /include/internal/cef_string_multimap.h
  cef_string_multimap_alloc      : function : TCefStringMultimap; cdecl;
  cef_string_multimap_size       : function(map: TCefStringMultimap): NativeUInt; cdecl;
  cef_string_multimap_find_count : function(map: TCefStringMultimap; const key: PCefString): NativeUInt; cdecl;
  cef_string_multimap_enumerate  : function(map: TCefStringMultimap; const key: PCefString; value_index: NativeUInt; value: PCefString): Integer; cdecl;
  cef_string_multimap_key        : function(map: TCefStringMultimap; index: NativeUInt; key: PCefString): Integer; cdecl;
  cef_string_multimap_value      : function(map: TCefStringMultimap; index: NativeUInt; value: PCefString): Integer; cdecl;
  cef_string_multimap_append     : function(map: TCefStringMultimap; const key, value: PCefString): Integer; cdecl;
  cef_string_multimap_clear      : procedure(map: TCefStringMultimap); cdecl;
  cef_string_multimap_free       : procedure(map: TCefStringMultimap); cdecl;

  // /include/internal/cef_string_types.h
  cef_string_wide_set             : function(const src: PWideChar; src_len: NativeUInt; output: PCefStringWide; copy: Integer): Integer; cdecl;
  cef_string_utf8_set             : function(const src: PAnsiChar; src_len: NativeUInt; output: PCefStringUtf8; copy: Integer): Integer; cdecl;
  cef_string_utf16_set            : function(const src: PChar16; src_len: NativeUInt; output: PCefStringUtf16; copy: Integer): Integer; cdecl;
  cef_string_wide_clear           : procedure(str: PCefStringWide); cdecl;
  cef_string_utf8_clear           : procedure(str: PCefStringUtf8); cdecl;
  cef_string_utf16_clear          : procedure(str: PCefStringUtf16); cdecl;
  cef_string_wide_cmp             : function(const str1, str2: PCefStringWide): Integer; cdecl;
  cef_string_utf8_cmp             : function(const str1, str2: PCefStringUtf8): Integer; cdecl;
  cef_string_utf16_cmp            : function(const str1, str2: PCefStringUtf16): Integer; cdecl;
  cef_string_wide_to_utf8         : function(const src: PWideChar; src_len: NativeUInt; output: PCefStringUtf8): Integer; cdecl;
  cef_string_utf8_to_wide         : function(const src: PAnsiChar; src_len: NativeUInt; output: PCefStringWide): Integer; cdecl;
  cef_string_wide_to_utf16        : function(const src: PWideChar; src_len: NativeUInt; output: PCefStringUtf16): Integer; cdecl;
  cef_string_utf16_to_wide        : function(const src: PChar16; src_len: NativeUInt; output: PCefStringWide): Integer; cdecl;
  cef_string_utf8_to_utf16        : function(const src: PAnsiChar; src_len: NativeUInt; output: PCefStringUtf16): Integer; cdecl;
  cef_string_utf16_to_utf8        : function(const src: PChar16; src_len: NativeUInt; output: PCefStringUtf8): Integer; cdecl;
  cef_string_ascii_to_wide        : function(const src: PAnsiChar; src_len: NativeUInt; output: PCefStringWide): Integer; cdecl;
  cef_string_ascii_to_utf16       : function(const src: PAnsiChar; src_len: NativeUInt; output: PCefStringUtf16): Integer; cdecl;
  cef_string_userfree_wide_alloc  : function : PCefStringUserFreeWide; cdecl;
  cef_string_userfree_utf8_alloc  : function : PCefStringUserFreeUtf8; cdecl;
  cef_string_userfree_utf16_alloc : function : PCefStringUserFreeUtf16; cdecl;
  cef_string_userfree_wide_free   : procedure(str: PCefStringUserFreeWide); cdecl;
  cef_string_userfree_utf8_free   : procedure(str: PCefStringUserFreeUtf8); cdecl;
  cef_string_userfree_utf16_free  : procedure(str: PCefStringUserFreeUtf16); cdecl;
  cef_string_utf16_to_lower       : function(const src: PChar16; src_len: NativeUInt; output: PCefStringUtf16): Integer; cdecl;
  cef_string_utf16_to_upper       : function(const src: PChar16; src_len: NativeUInt; output: PCefStringUtf16): Integer; cdecl;

  // /include/internal/cef_thread_internal.h
  cef_get_current_platform_thread_id     : function : TCefPlatformThreadId; cdecl;
  cef_get_current_platform_thread_handle : function : TCefPlatformThreadHandle; cdecl;

  // /include/internal/cef_time.h
  cef_time_to_timet         : function(const cef_time: PCefTime; out time_: Int64): integer; cdecl;
  cef_time_from_timet       : function(time_: int64; out cef_time: TCefTime): integer; cdecl;
  cef_time_to_doublet       : function(const cef_time: PCefTime; out time_: double): integer; cdecl;
  cef_time_from_doublet     : function(time: double; out cef_time: TCefTime): integer; cdecl;
  cef_time_now              : function(out cef_time: TCefTime): integer; cdecl;
  cef_basetime_now          : function : TCefBaseTime; cdecl;
  cef_time_delta            : function(const cef_time1, cef_time2: PCefTime; out delta: int64): integer; cdecl;
  cef_time_to_basetime      : function(const from: PCefTime; to_: PCefBaseTime) : integer; cdecl;
  cef_time_from_basetime    : function(const from: TCefBaseTime; to_: PCefTime) : integer; cdecl;

  // /include/internal/cef_trace_event_internal.h
  cef_trace_event_instant         : procedure(const category, name, arg1_name: PAnsiChar; arg1_val: uint64; const arg2_name: PAnsiChar; arg2_val: UInt64); cdecl;
  cef_trace_event_begin           : procedure(const category, name, arg1_name: PAnsiChar; arg1_val: UInt64; const arg2_name: PAnsiChar; arg2_val: UInt64); cdecl;
  cef_trace_event_end             : procedure(const category, name, arg1_name: PAnsiChar; arg1_val: UInt64; const arg2_name: PAnsiChar; arg2_val: UInt64); cdecl;
  cef_trace_counter               : procedure(const category, name, value1_name: PAnsiChar; value1_val: UInt64; const value2_name: PAnsiChar; value2_val: UInt64); cdecl;
  cef_trace_counter_id            : procedure(const category, name: PAnsiChar; id: UInt64; const value1_name: PAnsiChar; value1_val: UInt64; const value2_name: PAnsiChar; value2_val: UInt64); cdecl;
  cef_trace_event_async_begin     : procedure(const category, name: PAnsiChar; id: UInt64; const arg1_name: PAnsiChar; arg1_val: UInt64; const arg2_name: PAnsiChar; arg2_val: UInt64); cdecl;
  cef_trace_event_async_step_into : procedure(const category, name: PAnsiChar; id, step: UInt64; const arg1_name: PAnsiChar; arg1_val: UInt64); cdecl;
  cef_trace_event_async_step_past : procedure(const category, name: PAnsiChar; id, step: UInt64; const arg1_name: PAnsiChar; arg1_val: UInt64); cdecl;
  cef_trace_event_async_end       : procedure(const category, name: PAnsiChar; id: UInt64; const arg1_name: PAnsiChar; arg1_val: UInt64; const arg2_name: PAnsiChar; arg2_val: UInt64); cdecl;

  {$IFDEF LINUX}
  // /include/internal/cef_types_linux.h
  cef_get_xdisplay                : function : PXDisplay; cdecl;
  {$ENDIF}

implementation

end.

