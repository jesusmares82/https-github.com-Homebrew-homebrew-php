require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Hprose < AbstractPhp70Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.5.tgz"
  sha256 "a453053719dad6352d54543d708d8d09b62de28df7b29fd47b4b5a9fcf8025a7"
  head "https://github.com/hprose/hprose-pecl.git"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "316c522910e7923edeb926b3fd7d0f06d5154346be68de13362ae251f9a3f7ce" => :el_capitan
    sha256 "4f615dde19536375876a2f554a46cb0356cf952b7ce463fdb6e5a21dcc2ad3e2" => :yosemite
    sha256 "59b018513dbc182e6525e387d3bd4e04da9769f7b17ac5e9aca287db859199f0" => :mavericks
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
