require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ds < AbstractPhp70Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.2.4.tar.gz"
  sha256 "c080bb08445fe690da2271ff866602cf27cadee529ab1a1edbf4aa7a1d6e104c"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bef59b0f46c72e6a3e8e136803b73a377c626018c7071f70e648d14bb728c625" => :sierra
    sha256 "8084469526b4c903bad13c449d83159094c174b7662993804eb6d7ef7b1ab6ba" => :el_capitan
    sha256 "c7e9b0b0f07c98c94635bd7d23e56152528530d4c558ec15906ff55ac4b6cefb" => :yosemite
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
