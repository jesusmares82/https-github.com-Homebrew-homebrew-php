require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "347022a9bd1640a4553188d1724c76a0d2f8c23dbbbbb4f62e117e8c27cdf54b" => :el_capitan
    sha256 "552425ff6ef08f0e767b67dc05bf887eb649584185b191d9c761af1ab9ace966" => :yosemite
    sha256 "9957aaeb4590466dfd628c1db414c565c66faa7544d8ae9cef19372ee9596b60" => :mavericks
  end

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
