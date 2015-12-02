require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Gearman < AbstractPhp53Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://pecl.php.net/package/gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://svn.php.net/repository/pecl/gearman/trunk/"

  bottle do
    sha256 "6df13554bc809e1229791648a8fc73e1a7d27cd336c16d4aa8942049e82eff3f" => :yosemite
    sha256 "e18fee51e7d674f32128598528b203e6c95155a5b3a268e34a21a7ef00532e8e" => :mavericks
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
