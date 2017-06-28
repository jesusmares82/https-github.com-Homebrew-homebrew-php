require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Stats < AbstractPhp72Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-2.0.1.tgz"
  sha256 "994da82975364773248091bb3f83cc5f101db70e88c79af8a60bea8ad054dd06"
  head "https://git.php.net/repository/pecl/math/stats.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce616f0b8cf8fcd16c95f77f0f5c5e4ba9c1c520ed31c666f00ad756a7dd88be" => :sierra
    sha256 "d60ca0857b3446a48dd9e67086484c95fe396b9f7adc53895ccf82e72745b257" => :el_capitan
    sha256 "2cd9e8321ed544e9d1f3429fbac80cbc2171275ef765e777823508626abc3f74" => :yosemite
  end

  def install
    Dir.chdir "stats-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/stats.so"
    write_config_file if build.with? "config-file"
  end
end
