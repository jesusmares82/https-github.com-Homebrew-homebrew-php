require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Lzf < AbstractPhp70Extension
  init
  desc "handles LZF de/compression"
  homepage "https://pecl.php.net/package/lzf"
  url "https://pecl.php.net/get/LZF-1.6.3.tgz"
  sha256 "42ec458ea10128a801e8d39736b519ba81fa75d2a617d2777b7d6b3276601a5d"
  head "http://svn.php.net/repository/pecl/lzf/trunk/"

  bottle do
    cellar :any
    sha256 "e9913ea66d85cb6f90306e268d2220c5dcfa87e6522fe780de585103fe26472d" => :yosemite
    sha256 "c8621911a5361c77d6aeee001d956eccd5803944d2ada674d828506ca8b004c3" => :mavericks
    sha256 "a79956a38739720cdd012545e76a2302eddf85fae37186f310506234f1312b8c" => :mountain_lion
  end

  def install
    Dir.chdir "LZF-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/lzf.so"
    write_config_file if build.with? "config-file"
  end
end
