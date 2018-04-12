require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Uuid < AbstractPhp70Extension
  init
  desc "UUID extension"
  homepage "https://pecl.php.net/package/uuid"

  stable do
    url "https://pecl.php.net/get/uuid-1.0.4.tgz"
    sha256 "63079b6a62a9d43691ecbcd4eb52e5e5fe17b5a3d0f8e46e3c17ff265c06a11f"

    patch do
      # let's fix the path to uuid.h (uuid/uuid.h on linux, ossp/uuid.h on OSX)
      # uuid_mac & uuid_time might not be available on OSX, let's add test to avoid compiling issue on these functions
      url "https://gist.githubusercontent.com/romainneutron/fe068c297413aee565d5/raw/28d6ba0b6e902e82e71bb9a1ed768c836a8161e4/php-uuid-1.0.4"
      sha256 "5f0664d5c4f55d4f6c037dab9f198e697afa3f9266854ed3945d7697fdb692b2"
    end
  end
  bottle do
    cellar :any_skip_relocation
    sha256 "02d37b20bd5ce57f33b69fbc77ae9a949d4431fe7206e0154f4af6ab8067e766" => :el_capitan
    sha256 "852a89b651a1fc6a8b95ead691900954d1560d1a125850152ee696952fd6c1ab" => :yosemite
    sha256 "d69cd48207e559fa2fbd2d63aab5d227325bae2d66563cb1fa359d32f974b02e" => :mavericks
  end


  head do
    url "https://git.php.net/repository/pecl/networking/uuid.git"

    patch do
      # let's fix the path to uuid.h (uuid/uuid.h on linux, ossp/uuid.h on OSX)
      # uuid_mac & uuid_time might not be available on OSX, let's add test to avoid compiling issue on these functions
      url "https://gist.githubusercontent.com/romainneutron/059b5795d205640ebf5a/raw/3ccec57f9a960ee04e4c2f9d80b16ab070d0fe65/php-uuid-master"
      sha256 "4025b2e99032b447fcf244dacac7fdeb601b3aa40204a3cdd9e475c5c2fa15cd"
    end
  end

  depends_on "ossp-uuid"

  def install
    Dir.chdir "uuid-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/uuid.so"
    write_config_file if build.with? "config-file"
  end
end
