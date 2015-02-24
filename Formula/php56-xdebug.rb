require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  homepage 'http://xdebug.org'
  url 'http://xdebug.org/files/xdebug-2.3.1.tgz'
  sha1 'e552cea58e533793d904b62713d7da5546028c76'
  head 'https://github.com/xdebug/xdebug.git'

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha1 "20c29fda6b569a281b4f218a3762b39f9f016aaf" => :yosemite
    sha1 "e770b5036c4a0ed8fee4c68b80da4095aade6c3a" => :mavericks
    sha1 "6adf555202903d0b281e7f80819c2f312759beec" => :mountain_lion
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
