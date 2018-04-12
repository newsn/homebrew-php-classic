require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class PhpCodeSniffer < Formula
  desc "Check coding standards in PHP, JavaScript and CSS"
  homepage "https://pear.php.net/package/PHP_CodeSniffer"
  url "http://download.pear.php.net/package/PHP_CodeSniffer-3.2.3.tgz"
  sha256 "eea9fc447b424a01e892be28970f30ba49810528291f70e8f36935ed12caf138"

  bottle do
    cellar :any_skip_relocation
    sha256 "c673632d810cdd7c4c5794d868a567f0b4e8a39d502232917167380be0af10db" => :high_sierra
    sha256 "c673632d810cdd7c4c5794d868a567f0b4e8a39d502232917167380be0af10db" => :sierra
    sha256 "c673632d810cdd7c4c5794d868a567f0b4e8a39d502232917167380be0af10db" => :el_capitan
  end

  depends_on PhpMetaRequirement

  def phpcs_standards
    etc+name+"Standards"
  end

  def phpcs_script_name
    "phpcs"
  end

  def phpcbf_script_name
    "phpcbf"
  end

  def install
    prefix.install Dir["PHP_CodeSniffer-#{version}/*"]

    if File.symlink? libexec+phpcs_script_name
      File.delete libexec+phpcs_script_name
    end
    libexec.install_symlink prefix+"bin"+phpcs_script_name

    if File.symlink? libexec+phpcbf_script_name
      File.delete libexec+phpcbf_script_name
    end
    libexec.install_symlink prefix+"bin"+phpcbf_script_name

    # Remove Windows batch files
    File.delete bin+"phpcbf.bat"
    File.delete bin+"phpcs.bat"

    # Make sure the config file is preserved on upgrades. We do that
    # be substituting @data_dir@ with #{etc} and making sure the
    # folder #{etc}/PHP_CodeSniffer exists.
    if File.exist?(prefix+"CodeSniffer.conf")
      (etc+"PHP_CodeSniffer").mkpath
      inreplace "#{prefix}/CodeSniffer.conf", /@data_dir@/, etc
    end

    # Create a place for other formulas to link their standards.
    phpcs_standards.mkpath

    # Configure installed_paths, but don't overwrite it if already set
    # (preserve config).
    `#{bin+phpcs_script_name} --config-show | grep -q installed_paths`
    unless $CHILD_STATUS.to_i.zero?
      system bin+phpcs_script_name, "--config-set", "installed_paths", phpcs_standards
    end
  end

  def caveats; <<~EOS
    Verify your installation by running:

      #{phpcs_script_name} --version

    You can read more about phpcs by running:

      brew home #{name}

    Sniffs must be upgraded to be compatible with version 3.0

      https://github.com/squizlabs/PHP_CodeSniffer/wiki/Version-3.0-Upgrade-Guide

    EOS
  end

  test do
    (testpath/"test.php").write <<~EOS
      <?php
      echo "foo"."bar"
    EOS
    system bin+phpcs_script_name, "--standard=Zend", "test.php"
    system "#{bin}/#{phpcs_script_name} --standard=PEAR --report=emacs test.php | grep -q 'error - Missing file doc comment'"
  end
end
