Django friendly finite state machine support
============================================

django-mfs adds declarative states management for django models.
Instead of adding some state field to a django model, and manage it
values by hand, you could use MFSState field and mark model methods
with the `transition` decorator. Your method will contain the side-effects
of the state change.

The decorator also takes a list of conditions, all of which must be met
before a transition is allowed.

Installation
------------

    $ pip install django-mfs

Or, for the latest git version

   $ pip install -e git://github.com/kmmbvnr/django-mfs.git#egg=django-mfs

Library have full Python 3 support, for graph transition drawing
you should install python3 compatible graphviz version
from git+https://github.com/philipaxer/pygraphviz

Usage
-----

Add MFSState field to your model

    from django_mfs.db.fields import MFSField, transition

    class BlogPost(models.Model):
        state = MFSField(default='new')


Use the `transition` decorator to annotate model methods

    @transition(source='new', target='published')
    def publish(self):
        """
        This function may contain side-effects, 
        like updating caches, notifying users, etc.
        The return value will be discarded.
        """

`source` parameter accepts a list of states, or an individual state.
You can use `*` for source, to allow switching to `target` from any state.

If calling publish() succeeds without raising an exception, the state field
will be changed, but not written to the database.

    from django_mfs.db.fields import can_proceed

    def publish_view(request, post_id):
        post = get_object__or_404(BlogPost, pk=post_id)
        if not can_proceed(post.publish):
             raise Http404;

        post.publish()
        post.save()
        return redirect('/')

If you are using the transition decorator with the `save` argument set to `True`,
the new state will be written to the database

    @transition(source='new', target='published', save=True)
    def publish(self):
        """
        Side effects other than changing state goes here
        """

If you require some conditions to be met before changing state, use the
`conditions` argument to `transition`. `conditions` must be a list of functions
that takes one argument, the model instance.  The function must return either
`True` or `False` or a value that evaluates to `True` or `False`. If all
functions return `True`, all conditions are considered to be met and transition
is allowed to happen. If one of the functions return `False`, the transition
will not happen. These functions should not have any side effects.

You can use ordinary functions

    def can_publish(instance):
        # No publishing after 17 hours
        if datetime.datetime.now().hour > 17:
           return False
        return True

Or model methods

    def can_destroy(self):
        return self.is_under_investigation()

Use the conditions like this:

    @transition(source='new', target='published', conditions=[can_publish])
    def publish(self):
        """
        Side effects galore
        """

    @transition(source='*', target='destroyed', conditions=[can_destroy])
    def destroy(self):
        """
        Side effects galore
        """

You could instantiate field with protected=True option, that prevents direct state field modification

    class BlogPost(models.Model):
        state = MFSField(default='new', protected=True)

    model = BlogPost()
    model.state = 'invalid' # Raises AttributeError


### get_available_FIELD_transitions

You could specify MFSField explicitly in transition decorator.

    class BlogPost(models.Model):
        state = MFSField(default='new')

        @transition(field=state, source='new', target='published')
        def publish(self):
    	    pass

This allows django_mfs to contribute to model class get_available_FIELD_transitions method,
that returns list of (target_state, method) available from current model state

### Foreign Key constraints support 

If you store the states in the db table you could use MFSKeyField to
ensure Foreign Key database integrity.

### Signals

`django_mfs.signals.pre_transition` and `django_mfs.signals.post_transition` are called before 
and after allowed transition. No signals on invalid transition are called.

Arguments sent with these signals:

**sender**
   The model class.

**instance**
   The actual instance being proceed

**name**
   Transition name

**source**
   Source model state

**target**
   Target model state


### Drawing transitions

    Renders a graphical overview of your models states transitions

    # Create a dot file
    $ ./manage.py graph_transitions > transitions.dot

    # Create a PNG image file only for specific model
    $ ./manage.py graph_transitions -o blog_transitions.png myapp.Blog


Changelog
---------
django-mfs 1.5.1 2014-01-04

    * Ad-hoc support for state fields from proxy and inherited models

django-mfs 1.5.0 2013-09-17

    * Python 3 compatibility

django-mfs 1.4.0 2011-12-21

    * Add graph_transition command for drawing state transition picture

django-mfs 1.3.0 2011-07-28

    * Add direct field modification protection

django-mfs 1.2.0 2011-03-23

    * Add pre_transition and post_transition signals

django-mfs 1.1.0 2011-02-22

    * Add support for transition conditions 
    * Allow multiple MFSField in one model
    * Contribute get_available_FIELD_transitions for model class

django-mfs 1.0.0 2010-10-12

    * Initial public release

