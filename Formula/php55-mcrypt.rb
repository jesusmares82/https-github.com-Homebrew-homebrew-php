require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "9db99a01cb8d2268614002a19f044c00ef14fc07f7ac37c1cd7aa68076df7588" => :el_capitan
    sha256 "4c5373341382a30218bc142b745e977dd83dcbb57c7331c81c1c84622f731640" => :yosemite
    sha256 "0a5e6308d83d3ab0c94081afb53aedf65c623470e5029aeaf58737001af061d3" => :mavericks
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




