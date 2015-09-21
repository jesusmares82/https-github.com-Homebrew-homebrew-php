require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gearman < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://svn.php.net/repository/pecl/gearman/trunk/"

  bottle do
    sha256 "a75449715d8bd347092edf9b3d8544287b708a3c9c4826d6856a544803ed46f3" => :el_capitan
    sha256 "736a0e422989c7922f26b3b6a245eabeaec0686c2018b8fbf9c3b41a9955f8a9" => :yosemite
    sha256 "ebdec8c9087cce10dc11161dd3447b9c2a038f24e154d0af17646baa3edc4fbb" => :mavericks
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
