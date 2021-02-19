// Misc
const APP_NAME = 'X~Currency';
const AMOUNT_FORMAT = '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$';
const ON_CHANGE_DEBOUNCE_TIME = 500;
const DATE_FORMAT = 'MM/dd/yy HH:mm:ss';

// Error messages
const ERR_CURRENCY_GET = 'Could not retrieve list of currencies.';
const ERR_CURRENCY_PARSE = 'Got wrong list of currencies format.';
const ERR_CONVERSION_RATE_GET = 'Could not retrieve rate for conversion';
const ERR_CONVERSION_RATE_PARSE = 'Got wrong rate format';
const ERR_CONVERSION_RATE_TO = 'Could not retrieve rate for converting to:';

// Defaults
const DEFAULT_CURRENCY_FROM = 'USD';
const DEFAULT_CURRENCY_TO = 'EUR';
const DEFAULT_MULTIPLIER = 0.0;

// App layout and style
const APP_FONT_SIZE = 20.0;
const APP_FONT_SIZE_SMALL = 16.0;
const APP_PADDING = 16.0;
const APP_PADDING_HALF = APP_PADDING / 2;

// OpenRates API
const BASE_URL = 'https://api.openrates.io';