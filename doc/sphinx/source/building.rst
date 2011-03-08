Building the module
===================

Binary packages will probably be available in the future, but
currently you need to build the ``sf`` module from source.


Building without Cython
-----------------------

I've tried to keep the C++ generated file under source control, but it
seemed to take too much space, so I removed it. You'll have install
Cython and read the next section to build the module from the latest
source.

When the module gets somewhat stable, however, I will make a release
that you'll be able to build with Cython installed. This section is
relevant to that use case.

Make sure that ``USE_CYTHON`` is set to ``False`` in setup.py.  You
can then build the module by typing this command::

    python setup.py build_ext --inplace

The ``--inplace`` option means that the module will be dropped in the
current directory, which is usually more practical.


Building with Cython installed
------------------------------

If you have modified the source, you'll need to install Cython to
build a module including the changes.  Also, make sure that
``USE_CYTHON`` is set to ``True`` in setup.py.

When you've done so, you can build the module by typing this command::

    python setup.py build_ext --inplace

The ``--inplace`` option means that the module will be dropped in the
current directory, which is usually more practical.
