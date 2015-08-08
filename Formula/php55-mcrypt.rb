require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    sha256 "9ef8b5c12942f3442de62c420914058f4ca5346e5d42a65adabb05b08f67974d" => :yosemite
    sha256 "32e4a0b7442ea4d333955ff59baa48793f399f0e38eedc6a495469c66409c8c8" => :mavericks
    sha256 "6cbef87daf25eb39a52063f43f86edb55cda4afb0a5ca109c803761c9f5cf793" => :mountain_lion
  end

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula['mcrypt'].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end

