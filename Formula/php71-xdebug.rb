require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"

  devel do
    url "https://xdebug.org/files/xdebug-2.6.0beta1.tgz"
    sha256 "49de661e1e18cbbd739fc9fb7a014a36f97a84d2c4a89417c358dd258340527d"
  end

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
