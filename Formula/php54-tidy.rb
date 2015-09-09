require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Tidy < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    revision 1
    sha256 "a537a440867caf099927f80bee762678e8aa9bbfccfdb6825def1fff47421d9f" => :yosemite
    sha256 "077363edd8fbef83810de1e43a4899c0d6c5b27409426820f209f6fe09568f83" => :mavericks
    sha256 "8a408ef0044cf6068f89df0fbf56a3221bdb4772a3e6131369c7a2413098e23a" => :mountain_lion
  end

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end

