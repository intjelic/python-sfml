Building the module
===================

Building without Cython
-----------------------




Building with Cython installed
------------------------------

If you have modified the source, you'll need to install Cython to
build a module including the changes.

When you've done so, you can build the module by typing this command::

    python setup.py build_ext --inplace

The ``--inplace`` option means that the module will be dropped in the
current directory, which is usually more practical.
