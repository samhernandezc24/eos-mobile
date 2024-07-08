/// Unificación de las librerías que son comúnes en toda la aplicación.
library;

/// =========================================================
/// DART MATH
/// =========================================================
export 'dart:math';

/// =========================================================
/// DART COLLECTION
/// =========================================================
export 'package:collection/collection.dart';

/// =========================================================
/// DIO (HTTP OPERATIONS)
/// =========================================================
export 'package:dio/dio.dart';

/// =========================================================
/// CONFIG (LOGIC CONTROLLERS, ROUTER)
/// =========================================================
export 'package:eos_mobile/config/logic/app_logic.dart';
export 'package:eos_mobile/config/logic/settings_logic.dart';
export 'package:eos_mobile/config/router/app_router.dart';

/// =========================================================
/// CORE
/// =========================================================
export 'package:eos_mobile/core/constants/app_strings.dart';
export 'package:eos_mobile/core/constants/assets.dart';
export 'package:eos_mobile/core/constants/data_source_manager.dart';
export 'package:eos_mobile/core/constants/globals.dart';
export 'package:eos_mobile/core/extensions/alignments_extension.dart';
export 'package:eos_mobile/core/extensions/sized_context_extension.dart';
export 'package:eos_mobile/core/extensions/string_extension.dart';
export 'package:eos_mobile/core/network/data_state.dart';
export 'package:eos_mobile/core/network/errors/exceptions.dart';
export 'package:eos_mobile/core/usecase/usecase.dart';
export 'package:eos_mobile/core/validators/form_validators.dart';

/// =========================================================
/// LAYOUTS
/// =========================================================
export 'package:eos_mobile/layouts/app_scaffold.dart';
export 'package:eos_mobile/layouts/app_scaffold_with_navbar.dart';

/// =========================================================
/// MAIN
/// =========================================================
export 'package:eos_mobile/main.dart';

/// =========================================================
/// APP STYLES
/// =========================================================
export 'package:eos_mobile/styles/app_styles.dart';

/// =========================================================
/// UI WIDGET (COMPONENTS)
/// =========================================================
export 'package:eos_mobile/ui/common/app_icons.dart';
export 'package:eos_mobile/ui/common/controls/app_linear_indicator.dart';
export 'package:eos_mobile/ui/common/controls/app_loading_indicator.dart';
export 'package:eos_mobile/ui/common/controls/buttons.dart';
export 'package:eos_mobile/ui/common/controls/circle_buttons.dart';
export 'package:eos_mobile/ui/common/controls/date_text_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_datetime_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_dropdown_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_password_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_text_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_textarea_form_field.dart';
export 'package:eos_mobile/ui/common/controls/labeled_time_form_field.dart';
export 'package:eos_mobile/ui/common/controls/scroll_decorator.dart';
export 'package:eos_mobile/ui/common/controls/server_error_dialog.dart';
export 'package:eos_mobile/ui/common/controls/server_failed_message.dart';
export 'package:eos_mobile/ui/common/controls/time_text_form_field.dart';
export 'package:eos_mobile/ui/common/data_source/empty_results_message.dart';
export 'package:eos_mobile/ui/common/data_source/search_filters_action_sheet.dart';
export 'package:eos_mobile/ui/common/data_source/search_input.dart';
export 'package:eos_mobile/ui/common/data_source/shimmer_loading.dart';
export 'package:eos_mobile/ui/common/data_source/sort_action_sheet.dart';
export 'package:eos_mobile/ui/common/empty_list_message.dart';
export 'package:eos_mobile/ui/common/eos_mobile_logo.dart';
export 'package:eos_mobile/ui/common/error_server_message.dart';
export 'package:eos_mobile/ui/common/image_fade.dart';
export 'package:eos_mobile/ui/common/modals/app_modal_route.dart';
export 'package:eos_mobile/ui/common/predictive/predictive_search_form_field.dart';
export 'package:eos_mobile/ui/common/static_text_scale.dart';
export 'package:eos_mobile/ui/common/themed_text.dart';

/// =========================================================
/// EQUATABLE
/// =========================================================
export 'package:equatable/equatable.dart';

/// =========================================================
/// FLEX SEED SCHEME
/// =========================================================
export 'package:flex_color_scheme/flex_color_scheme.dart';

/// =========================================================
/// FLUTTER WIDGETS
/// =========================================================
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';

/// =========================================================
/// FLUTTER ANIMATIONS
/// =========================================================
export 'package:flutter_animate/flutter_animate.dart';

/// =========================================================
/// FLUTTER BLOC
/// =========================================================
export 'package:flutter_bloc/flutter_bloc.dart';

/// =========================================================
/// GAP (FLUTTER WIDGET)
/// =========================================================
export 'package:gap/gap.dart';

/// =========================================================
/// GET IT (DEPENDENCY INJECTION)
/// =========================================================
export 'package:get_it/get_it.dart';
export 'package:get_it_mixin/get_it_mixin.dart';

/// =========================================================
/// ROUTER NAVIGATION
/// =========================================================
export 'package:go_router/go_router.dart';

/// =========================================================
/// LOGGER (CUSTOM DEBUG PRINT)
/// =========================================================
export 'package:logger/logger.dart';
