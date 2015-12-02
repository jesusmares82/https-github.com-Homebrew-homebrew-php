require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Midgard2 < AbstractPhp54Extension
  init
  desc "PHP5 API for Midgard persistent storage framework"
  homepage "http://www.midgard-project.org"
  url "https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz"
  sha256 "633ed2dce0c43222c13b2be1d2d044343f37e69cbdf727abc78ac53b6d871fe3"
  head "https://github.com/midgardproject/midgard-php5.git", :branch => "ratatoskr"

  bottle do
    sha256 "db08a1aaf225c6280be6333a9c7c09b24f853e5198572ec63bbc875d06b61dc0" => :el_capitan
    sha256 "1f6ad29dab58f63356624b90465e9a0ca5951735712e736619ecabbdbcc902a7" => :yosemite
    sha256 "0c6bd4f32296bbcabe14eed380a990f709091361fa06ac32f82fae0e0e878cc3" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "midgard2"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/midgard2.so"
    write_config_file if build.with? "config-file"
  end
end
