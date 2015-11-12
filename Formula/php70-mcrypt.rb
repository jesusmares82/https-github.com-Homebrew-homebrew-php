require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 6
    sha256 "99e5974b3a632bbcee73d9747b684808ef1eb1a83d133eac1a3bafbc874a25a0" => :el_capitan
    sha256 "1ddc8ef3c37dc1c41a3908a07e656b63537e8afb0cbe8a276cc3e03a2155d6dd" => :yosemite
    sha256 "090d4ac031ac9e3ffd75490ce33601d2971ac39ba682c91cf648cda1bccd3f3b" => :mavericks
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
end
