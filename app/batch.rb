require 'date'
require 'logger'
require 'aws-sdk-s3'

class OreFormatter < Logger::Formatter
  def call(severity, time, progname, msg)
    format = "[%s #%d] %5s -- %s: %s\n"
    format % ["#{time.strftime('%Y-%m-%d %H:%M:%S')}.#{'%06d' % time.usec.to_s}",
                $$, severity, progname, msg2str(msg)]
  end
end

logger = Logger.new(STDOUT)
logger.formatter = OreFormatter.new

begin
  sec = (ARGV[0]&.to_i || 0).clamp(0, 305)
  logger.info "sleep #{sec}"
  sleep sec

  now = DateTime.now

  s3 = Aws::S3::Client.new
  res = s3.put_object({
    body: {time: now, message: 'hoge'}.to_json,
    bucket: ENV['BUCKET_NAME'],
    key: "mlexam/out_#{now.strftime('%Y%m%d%H%M%S')}",
    storage_class: 'ONEZONE_IA'
  })

  logger.info res.inspect
rescue => e
  logger.error e
  exit!
end

