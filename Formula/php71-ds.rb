require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ds < AbstractPhp71Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.1.5.tar.gz"
  sha256 "0da5444d07cd283b369c98e177656a96508291b921c3e844b9be6c8269e08372"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "32578ef7fc8a2341776a6bd215797572bdeb931f6cbe2e978abf2a7aed2c10b8" => :el_capitan
    sha256 "9834ad6c0ca41b91c5751b0281a72b536df0ee284ee3736a674cdfad679b8f35" => :yosemite
    sha256 "15e7129a20b9a8fe75a33b3aaa04c744c7cec59d4d1abaa6d2676cc22157eb28" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
