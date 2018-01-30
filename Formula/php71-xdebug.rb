require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-2.6.0.tgz"
  sha256 "b5264cc03bf68fcbb04b97229f96dca505d7b87ec2fb3bd4249896783d29cbdc"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "d091a999f4d1f83b97f0cbbf651d1ef63d7ec157718dbc8aaa1ab45edfe00a3b" => :high_sierra
    sha256 "86e077db10f67489d65f2dc33eef6bbc911a73a274137df42e12c02e69ba8800" => :sierra
    sha256 "3bd2df1011e8f297e2447712511b39d76117bd7f3ab7ab9c70177fd7eb1c6de2" => :el_capitan
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
