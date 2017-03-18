require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 9

  bottle do
    sha256 "42c7b2b1ff6a2588a981fe73b0e40515a93f7616e85cef28188e479607ea3e1d" => :sierra
    sha256 "70fe5cf3aefe5ff46d62ca101f65da54f0f835fc83742ac48411147293e8b05c" => :el_capitan
    sha256 "3c8c618c0b9da769f937c3a134e43b930182b19aa37389080dc8c4a7ed9a9708" => :yosemite
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
