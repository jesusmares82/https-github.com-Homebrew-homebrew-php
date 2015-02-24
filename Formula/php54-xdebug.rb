require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Xdebug < AbstractPhp54Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.3.1.tgz'
  sha1 'e552cea58e533793d904b62713d7da5546028c76'
  head 'https://github.com/xdebug/xdebug.git'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "384a3c924f52b9e8d02c225022be0c90131544d0" => :yosemite
    sha1 "1f2b8521332185773a193a2a559bd3a6fd8c98e9" => :mavericks
    sha1 "fcaa11973780716dbab5ae0d92208bbb8a69c684" => :mountain_lion
  end

  def extension_type; "zend_extension"; end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
