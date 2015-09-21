require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Parsekit < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/parsekit"
  desc "PHP Opcode Analyser"
  url "https://pecl.php.net/get/parsekit-1.3.0.tgz"
  sha256 "447d5ec6412d6c8c6489b03e7333d3872944444610b74eafd608eddcb3bbaf08"
  head "https://github.com/php/pecl-php-parsekit.git"

  bottle do
    cellar :any
    sha256 "56a16622ca9276f9b7ad38f4fb827840a5294de36c521079906293ce0f5418a0" => :yosemite
    sha256 "b0bccbbddc882af1585e4566026013e618265322eb2603d0640737aa4307ac18" => :mavericks
    sha256 "27d3ec7b1b90e692396e34c5bbca37b09d610c79aca3c92d15d751b5db18bbf1" => :mountain_lion
  end

  def install
    Dir.chdir "parsekit-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/parsekit.so"
    prefix.install "examples"
    write_config_file if build.with? "config-file"
  end
end
