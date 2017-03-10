# Syncing changes from isotope-ui to isotope-light-ui

To get a general idea of the changes between the dark and light UI themes, run
the `compare.sh` script. For example:

```
$ ./compare.sh ../isotope-ui
/var/folders/cl/3dfc67dd7mnddy1246z38dznyc7_3c/T/tmp.jORi6DcSVO.log.diff
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
styles/atom.less
--- /dev/fd/63	2017-03-09 19:22:56.000000000 -0600
+++ /dev/fd/62	2017-03-09 19:22:56.000000000 -0600
@@ -65,7 +65,7 @@
 // make panes float
 body:not([zen='true']) {
   .item-views {
-    border: 1px solid @stroke; // isotope-ui-light: darker borders
+    border: 1px solid @item-views-stroke;
     border-top: none;
   }
 }

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[...]
```

The changes you want to take are the ones **NOT** marked by comments indicating isotope-light-ui. Those are changes made specifically to lighten the UI for the light version of the theme.

To take the updated changes wholesale, use the `sync.sh` script. For example:

```
$ ./sync.sh ../isotope-ui styles/editor-mini.less
Syncing ../isotope-ui/styles/editor-mini.less -> styles/editor-mini.less
```

If there are changes to files that have `// isotope-light-ui: blah` comments in them, you must make those updates manually yourself.
