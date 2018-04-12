require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Molten < AbstractPhp71Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  head "https://github.com/chuan-yun/Molten.git"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "a636885f775fca5aa10a0f904031e753ecd0354b6073072a844171165454a95f" => :high_sierra
    sha256 "99566ad780275d3a001f6b4cdab77e3c9ed4e762ad73593473c2acb3bd6e12e5" => :sierra
    sha256 "5d0235c2e21bd86b8723a7155135263738ce4031a9c866c3dc9160dc912389f4" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php71-redis"
  depends_on "php71-memcached"
  depends_on "php71-mongodb"

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
