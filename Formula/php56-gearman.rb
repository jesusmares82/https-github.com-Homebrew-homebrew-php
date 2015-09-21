require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gearman < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://svn.php.net/repository/pecl/gearman/trunk/"

  bottle do
    sha256 "9e349af83966feff2015b7e792f0a09370cf92955f4af78fb3aaa952c2dbd6fd" => :yosemite
    sha256 "e32196a1e2b0e147e6b5d368c86ba6622b1444b9acd043a2eb5c0f300f7a370f" => :mavericks
  end

  depends_on "gearman"

  def install
    Dir.chdir "gearman-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula["gearman"].opt_prefix}"
    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
