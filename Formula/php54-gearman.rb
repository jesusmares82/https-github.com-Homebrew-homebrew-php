require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Gearman < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://svn.php.net/repository/pecl/gearman/trunk/"

  bottle do
    sha256 "ae66a7bcafaa90f08b95c0cf0a4e8b16b52d6c945c87c3560eec335290b0a07b" => :el_capitan
    sha256 "4320907d8b8ef19ee8b246315a80648895f4d5d4ba12f307c4bc852efe03a9b4" => :yosemite
    sha256 "bf05a990d9c0f218e31d771f25b711dc84ef19dde2d302d0f4245c74048e989b" => :mavericks
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
