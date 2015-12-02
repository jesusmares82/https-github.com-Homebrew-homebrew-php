require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Protobuf < AbstractPhp55Extension
  init
  desc "Fast PHP Protocol Buffers implementation"
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/0.10.tar.gz"
  sha256 "442e83dd47f5052e7e0bd4a46ab190a46115781e3c520df8319779689920a411"

  bottle do
    cellar :any_skip_relocation
    sha256 "2f26fa247cde57129f0481fcb6e0b705d39b632399555dad312efbf2e39410e2" => :el_capitan
    sha256 "3bda0a0b31f79739eb484bc20c848aa990a50ebd67dc6094b412590ced5fb288" => :yosemite
    sha256 "7f753b15c3b392e26efef21f9c4531d53e4d1c58f9c3ee022ccff44300a525cb" => :mavericks
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
