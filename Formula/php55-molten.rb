require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Molten < AbstractPhp55Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  head "https://github.com/chuan-yun/Molten.git"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "f1d066f05c6926ff9da36fa5cb6f1cf4fb972068befa7e776a3be84147832692" => :high_sierra
    sha256 "59b14277f9508968f0fc2ebdc577c1dab1f77376fb6fcfc73fdcc311fbd0fab5" => :sierra
    sha256 "fbba846dbff0cbbbb29e3b56249c5e9db3d7a84b5111bcdffd16ac04285420c9" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php55-redis"
  depends_on "php55-memcached"
  depends_on "php55-mongodb"

  def install
    args = []
    args << "--enable-zipkin-header=yes" if build.with? "zipkin"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/Molten.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
    ; Molten is transparency tool for application tracing it self module call.
    ; It trace php app core call and output zipkin/opentracing format trace log.
    ; Provides features about muliti trace sapi, multi sampling type,
    ; upload tracing status, module control and muliti sink type.
    ; get more details see: https://github.com/chuan-yun/Molten and then configure below
    [molten]
    molten.enable=1
    molten.sink_type=4
    molten.tracing_cli=0
    molten.sink_http_uri=http://127.0.0.1:9411/api/v1/spans
    molten.service_name=php_test
    molten.sampling_rate=1
    EOS
  end
end
