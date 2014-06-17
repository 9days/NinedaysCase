package
{
	import ninedays.log.Appender;
	import ninedays.log.LogLevel;
	import ninedays.log.Logger;

	public class LoggerCase extends ninedaysCase
	{
		private var _appender:Appender;
		private var _logger:Logger;
		
		public function LoggerCase()
		{
			_logger = new Logger();
			_appender = new Appender();
			_appender.registerLogger(_logger);
			_appender.threshold = LogLevel.TRACE;
			_logger.error(this, "hello{0}{1}", " ", "world");
			_logger.warn(this, "hello{0}{1}", " ", "world");
		}
	}
}