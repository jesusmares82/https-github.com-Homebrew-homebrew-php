require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gearman < AbstractPhp70Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.1.tar.gz"
  sha256 "af5172d68fbf111e143d0f8e3a583532b236f1a7137696bc2117955034149adf"
  head "https://github.com/wcgallego/pecl-gearman.git"

  bottle do
    sha256 "c8e381e4245466a33d12effddc615406e6267ed36e0137754f1aaba5e738842d" => :el_capitan
    sha256 "0575426337a8092ae1e6dae0610d2b52f88db95c43319ce6b325e2fddbeaa174" => :yosemite
    sha256 "4a7f939d1701b6eb4276def33127311d7adcede0a8006873074f4cbf6fb3ca53" => :mavericks
  end

  depends_on "gearman"

  def install
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
