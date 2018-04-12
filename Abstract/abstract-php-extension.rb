require "formula"
require File.join(File.dirname(__FILE__), "abstract-php-version")

class UnsupportedPhpApiError < RuntimeError
  def initialize
    super "Unsupported PHP API Version"
  end
end

class InvalidPhpizeError < RuntimeError
  def initialize(installed_php_version, required_php_version)
    super <<~EOS
      Version of phpize (PHP#{installed_php_version}) in $PATH does not support building this extension version (PHP#{required_php_version}). Consider installing  with the `--without-homebrew-php` flag.
    EOS
  end
end

class AbstractPhpExtension < Formula
  def initialize(*)
    super

    if build.without? "homebrew-php"
      installed_php_version = nil
      i = IO.popen("#{phpize} -v")
      out = i.readlines.join("")
      i.close
      { 53 => 20090626, 54 => 20100412, 55 => 20121113, 56 => 20131106, 70 => 20151012, 71 => 20160303, 72 => 20170718 }.each do |v, api|
        installed_php_version = v.to_s if out.match(/#{api}/)
      end

      raise UnsupportedPhpApiError if installed_php_version.nil?

      required_php_version = php_branch.sub(".", "").to_s
      unless installed_php_version == required_php_version
        raise InvalidPhpizeError.new(installed_php_version, required_php_version)
      end
    end
  end

  def self.init
    depends_on "autoconf" => :build

    option "without-homebrew-php", "Ignore homebrew PHP and use default instead"
    option "without-config-file", "Do not install extension config file"
  end

  def php_branch
    class_name = self.class.name.split("::").last
    matches = /^Php([5,7])([0-9]+)/.match(class_name)
    if matches
      matches[1] + "." + matches[2]
    else
      raise "Unable to guess PHP branch for #{class_name}"
    end
  end

  def php_formula
    "php" + php_branch.sub(".", "")
  end

  def safe_phpize
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system phpize
  end

  def phpize
    if build.without? "homebrew-php"
      "phpize"
    else
      "#{Formula[php_formula].opt_bin}/phpize"
    end
  end

  def phpini
    if build.without? "homebrew-php"
      "php.ini presented by \"php --ini\""
    else
      "#{Formula[php_formula].config_path}/php.ini"
    end
  end

  def phpconfig
    if build.without? "homebrew-php"
      ""
    else
      "--with-php-config=#{Formula[php_formula].opt_bin}/php-config"
    end
  end

  def extension
    class_name = self.class.name.split("::").last
    matches = /^Php[5,7][0-9](.+)/.match(class_name)
    if matches
      matches[1].downcase
    else
      raise "Unable to guess PHP extension name for #{class_name}"
    end
  end

  def extension_type
    # extension or zend_extension
    "extension"
  end

  def module_path
    opt_prefix / "#{extension}.so"
  end

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
      EOS
  rescue StandardError
    nil
  end

  test do
    assert shell_output("#{Formula[php_formula].opt_bin}/php -m").downcase.include?(extension.downcase), "failed to find extension in php -m output"
  end

  def caveats
    caveats = ["To finish installing #{extension} for PHP #{php_branch}:"]

    if build.without? "config-file"
      caveats << "  * Add the following line to #{phpini}:\n"
      caveats << config_file
    else
      caveats << "  * #{config_scandir_path}/#{config_filename} was created,"
      caveats << "    do not forget to remove it upon extension removal."
    end

    caveats << <<-EOS
  * Validate installation via one of the following methods:
  *
  * Using PHP from a webserver:
  * - Restart your webserver.
  * - Write a PHP page that calls "phpinfo();"
  * - Load it in a browser and look for the info on the #{extension} module.
  * - If you see it, you have been successful!
  *
  * Using PHP from the command line:
  * - Run `php -i "(command-line 'phpinfo()')"`
  * - Look for the info on the #{extension} module.
  * - If you see it, you have been successful!
EOS

    caveats.join("\n")
  end

  def config_path
    etc / "php" / php_branch
  end

  def config_scandir_path
    config_path / "conf.d"
  end

  def config_filename
    "ext-" + extension + ".ini"
  end

  def config_filepath
    config_scandir_path / config_filename
  end

  def write_config_file
    if config_filepath.file?
      inreplace config_filepath do |s|
        s.gsub!(/^(;)?(\s*)(zend_)?extension=.+$/, "\\1\\2#{extension_type}=\"#{module_path}\"")
      end
    elsif config_file
      config_scandir_path.mkpath
      config_filepath.write(config_file)
    end
  end
end

class AbstractPhp53Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php53Defs

  def self.init(opts = [])
    super()
    depends_on "php53" => opts if build.with?("homebrew-php")
  end
end

class AbstractPhp54Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php54Defs

  def self.init(opts = [])
    super()
    depends_on "php54" => opts if build.with?("homebrew-php")
  end
end

class AbstractPhp55Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php55Defs

  def self.init(opts = [])
    super()
    depends_on "php55" => opts if build.with?("homebrew-php")
  end
end

class AbstractPhp56Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php56Defs

  def self.init(opts = [])
    super()
    depends_on "php56" => opts if build.with?("homebrew-php")
  end
end

class AbstractPhp70Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php70Defs

  def self.init(opts = [])
    super()
    depends_on "php70" => opts if build.with?("homebrew-php")
  end
end

class AbstractPhp71Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php71Defs

  def self.init(opts = [])
    super()
    depends_on "php71" => opts if build.with?("homebrew-php")
  end
end

class AbstractPhp72Extension < AbstractPhpExtension
  include AbstractPhpVersion::Php72Defs

  def self.init(opts = [])
    super()
    depends_on "php" => opts if build.with?("homebrew-php")
  end
end
