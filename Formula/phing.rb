require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phing < AbstractPhpPhar
  init
  desc "Ant-like build tool for PHP"
  homepage "https://www.phing.info"
  url "https://www.phing.info/get/phing-2.16.1.phar"
  sha256 "dcc7b63e1a1f8e1599b0fb33a02b053ee9adcdd2885538e36d7e1f5c81062040"

  bottle do
    cellar :any_skip_relocation
    sha256 "e3127051224976a1b241e491120bb50f3c32dbd7b5f94b81c114cf6c6cdd20d6" => :high_sierra
    sha256 "e3127051224976a1b241e491120bb50f3c32dbd7b5f94b81c114cf6c6cdd20d6" => :sierra
    sha256 "e3127051224976a1b241e491120bb50f3c32dbd7b5f94b81c114cf6c6cdd20d6" => :el_capitan
  end

  def phar_file
    "phing-#{version}.phar"
  end

  test do
    (testpath/"build.xml").write <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <project name="test" default="default">
      <target name="default">
        <echo msg="Test"/>
      </target>
    </project>
    EOS
    assert_match "[echo] Test", shell_output("#{bin}/phing")
  end
end
