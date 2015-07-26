require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "2ab708118dbb1654b58eb87fccf921052a0593743ada65c730048e5ed5c6d1da" => :yosemite
    sha256 "7fa3a64e042ca1e22fcc7f0148f7efd99199b4b8f42ce05ba728d70307f7b3f1" => :mavericks
    sha256 "47e3480b1788c5b4dcd1a02ddad1dd02769b5f21cb7c889428989f8825cd44a0" => :mountain_lion
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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

  test do
    shell_output("php -m").include?("mcrypt")
  end
end

