require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Molten < AbstractPhp56Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  head "https://github.com/chuan-yun/Molten.git"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "83013acc9c4f32dc86ac6aedc7291d70419418afe6b259b65f8bc3960a19dbb4" => :high_sierra
    sha256 "c89db0f7de08253349ac535e44f878a11cc48fe0feb054845168181de2ba54dc" => :sierra
    sha256 "b9dc93da289511df9452f2d75eae7638fa4b6160e47e7ff1985054c91a4ab6db" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php56-redis"
  depends_on "php56-memcached"
  depends_on "php56-mongodb"

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
