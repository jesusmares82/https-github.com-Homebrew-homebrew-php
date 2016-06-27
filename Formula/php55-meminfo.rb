require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Meminfo < AbstractPhp55Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v0.3.0",
    :revision => "a9e0eefe0b9c88abd7215f688ec0b04d0d20f386"
  head "https://github.com/BitOne/php-meminfo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "08b477a3cdfeda51adb2226222b32b49fdcb57b41d3f1414ad12e1cd3481745d" => :el_capitan
    sha256 "6ee138403fc41544e11b73125f4a284217f6fa9d4fdfe7a4f3bef3e98f71f381" => :yosemite
    sha256 "a4e15ea275fc24477b92ea5b0e1690fe9afd52f01004909e975d46f4b1cfc6dd" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/meminfo.so]
    write_config_file if build.with? "config-file"
  end
end
