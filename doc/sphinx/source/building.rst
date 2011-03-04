Building the module
===================

Binary packages will probably be available in the future, but
currently you need to build the ``sf`` module from source.


Building without Cython
-----------------------

If you simply want to build the current source, you don't need to
install Cython.
Make that ``USE_CYTHON`` is set to ``False`` in setup.py.
You can then build the module by typing this command::

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
