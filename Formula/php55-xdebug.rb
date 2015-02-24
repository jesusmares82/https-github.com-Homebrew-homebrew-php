require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.3.1.tgz'
  sha1 'e552cea58e533793d904b62713d7da5546028c76'
  head 'https://github.com/xdebug/xdebug.git'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "04024df55dfabee6255d4a9e7de19cfacd770bb9" => :yosemite
    sha1 "06b16bcfb2ee7d2ed4360bd5914fed6e090e29cd" => :mavericks
    sha1 "fbaeb1691fdd7bf8d4e719eeeb97d23de2d8ba17" => :mountain_lion
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
