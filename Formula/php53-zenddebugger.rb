require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Zenddebugger < AbstractPhp53Extension
  init
  desc "Zend Debugger is a full-featured php debugger engine."
  homepage "http://www.zend.com/community/pdt/downloads"
  bottle do
    cellar :any_skip_relocation
    sha256 "cdace9f17337778d998e4ecfff4171f81f9856153c235d9a403fbaedf3fe8f22" => :el_capitan
    sha256 "b2a14e99774393e8889f1366f535f0d73feba9bf84baf3621da4c6d3a5ffa38c" => :yosemite
    sha256 "c18af0f8a34dfd3ca92a030c01b87f03182ea3107d720d3439ee0a3a1d94d3b4" => :mavericks
  end

  if MacOS.prefer_64_bit?
    url "http://downloads.zend.com/studio_debugger/20100729/ZendDebugger-20100729-darwin9.5-x86_64.tar.gz"
    sha256 "87a7526738e1de1b20e055f06b7cfc46292e96e79a063893911e3ec42efa6213"
    version "20100729"
  else
    url "http://downloads.zend.com/studio_debugger/2011_04_10/ZendDebugger-20110410-darwin-i386.tar.gz"
    sha256 "23b6bee02df3de787d77f8f5e4b51f14a2d717ddea7d81b1f7e87815dd238e79"
    version "20110410"
  end

  def extension_type
    "zend_extension"
  end

  def install
    prefix.install "5_3_x_comp/ZendDebugger.so"
    prefix.install "dummy.php"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      zend_debugger.allow_hosts=127.0.0.1/32
      zend_debugger.allow_tunnel=
      zend_debugger.deny_hosts=
      zend_debugger.expose_remotely=always
      zend_debugger.httpd_uid=-1
      zend_debugger.max_msg_size=2097152
      zend_debugger.tunnel_max_port=65535
      zend_debugger.tunnel_min_port=1024
    EOS
  end
end
