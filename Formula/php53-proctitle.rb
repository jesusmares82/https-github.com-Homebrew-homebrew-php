require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Proctitle < AbstractPhp53Extension
  init
  desc "Allows setting the current process name on Linux and BSD."
  homepage "https://pecl.php.net/package/proctitle"
  url "https://pecl.php.net/get/proctitle-0.1.2.tgz"
  sha256 "b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272"
  head "https://github.com/MagicalTux/proctitle.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "db99f49172ec7a61324cc5c7f3c79404701508b243150011e567b35d96d5e20a" => :el_capitan
    sha256 "196a39c3310209fce1d594a74a9c760336119a006e6265af4faa9dd8544aae0d" => :yosemite
    sha256 "9348175965961a0269294585682d210feb01e5095f2d59f6d32b865fa9091a74" => :mavericks
  end

  def install
    Dir.chdir "proctitle-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/proctitle.so]
    write_config_file if build.with? "config-file"
  end
end
