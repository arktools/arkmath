#!/usr/bin/python 
# Author: Lenna X. Peterson (github.com/lennax)
# based on bash script by James Goppert (github.com/jgoppert)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# USAGE:                                                                      #
# $ ./autobuild.py [1-9]                                                      #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# TODO: Error handling: 
## check cmake success, etc.
## catch CMake Warning:
  #Manually-specified variables were not used by the project:
		  #BUILD_TYPE
  # (missing gprof flags)


import sys # for sys.argv[] and sys.platform
import os # for chdir()
import subprocess # for check_call()

makeargs = "-j8"
cmakeargs = " "
build_dir = "build"

def install_build(cmakeargs):
	try: 
		os.mkdir(build_dir)
	except OSError as (errno, errstr):
		if 'exists' in os.strerror(errno): # File exists: 17
			print "Directory '%s' exists" % build_dir
		else:
			raise
	os.chdir(build_dir)
	cmake_call = "cmake" + cmakeargs + ".."
	subprocess.check_call(cmake_call, shell=True)
	subprocess.check_call(["make", makeargs])
	raise SystemExit
	
def dev_build():
	# cmakeargs must begin and end with a space
	cmakeargs = " -DIN_SRC_BUILD::bool=TRUE "
	install_build(cmakeargs)

def grab_deps():
	if 'linux' in sys.platform:
		try: 
			subprocess.check_call('sudo apt-get install cmake', shell=True)
		except: 
			print "Error installing dependencies: ", sys.exc_info()[0]
			print "apt-get is available on Debian and Ubuntu" 
			raise SystemExit
	elif 'darwin' in sys.platform:
		try: 
			subprocess.check_call('sudo port install cmake', shell=True)
		except: 
			print "Error installing dependencies: ", sys.exc_info()[0]
			print "Please install Macports (http://www.macports.org)"
			raise SystemExit
	else: 
		print "Platform not recognized (did not match linux or darwin)"
	raise SystemExit

def package_source():
	install_build(cmakeargs)
	subprocess.check_call(["make", "package_source"])
	raise SystemExit

def package():
	install_build(cmakeargs)
	subprocess.check_call(["make", "package"])
	raise SystemExit

def remake():
	os.chdir(build_dir)
	subprocess.check_call(["make", makeargs])
	raise SystemExit

def clean():
	for root, dirs, files in os.walk(build_dir, topdown=False): 
		for name in files: 
			os.remove(os.path.join(root, name))
		for name in dirs: 
			os.rmdir(os.path.join(root, name))
	os.rmdir(build_dir)
	print "Build cleaned"

# requires PROFILE definition in CMakeLists.txt:
# set(CMAKE_BUILD_TYPE PROFILE)
# set(CMAKE_CXX_FLAGS_PROFILE "-g -pg")
# set(CMAKE_C_FLAGS_PROFILE "-g -pg")
def profile():
	cmakeargs = " -DBUILD_TYPE=PROFILE -DIN_SRC_BUILD::bool=TRUE "
	install_build(cmakeargs)
	
def menu():
	print "1. developer build: used for development."
	print "2. install build: used for building before final installation to the system."
	print "3. grab dependencies: installs all the required packages for debian based systems (ubuntu maverick/ debian squeeze,lenny) or darwin with macports."
	print "4. package source: creates a source package for distribution."
	print "5. package: creates binary packages for distribution."
	print "6. remake: calls make again after project has been configured as install or in source build."
	print "7. clean: removes the build directory."
	print "8. profile: compiles for gprof."
	print "9. end."
	opt = raw_input("Please choose an option: ")
	return opt

try: 
	loop_num = 0
	# continues until a function raises system exit
	while (1): 	
		if len(sys.argv) == 2 and loop_num == 0:
			opt = sys.argv[1]
			loop_num += 1
		else:
			opt = menu()

		opt = int(opt)
		if   opt == 1:
			print "You chose developer build"
			dev_build()
		elif opt == 2:
			print "You chose install build"
			install_build(cmakeargs)
		elif opt == 3: 
			print "You chose to install dependencies"
			grab_deps()
		elif opt == 4:
			print "You chose to package the source"
			package_source()
		elif opt == 5:
			print "You chose to package the binary"
			package()
		elif opt == 6:
			print "You chose to re-call make on the previously configured build"
			remake()
		elif opt == 7:
			print "You chose to clean the build"
			clean()
		elif opt == 8:
			# requires definition in CMakeLists.txt (see def above)
			print "You chose to compile for gprof"
			profile()
		elif opt == 9:
			raise SystemExit
		else:
			print "Invalid option. Please try again: " 
		
except KeyboardInterrupt: 
	print "\n" 
