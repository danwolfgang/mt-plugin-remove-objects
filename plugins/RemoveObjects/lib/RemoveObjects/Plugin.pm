package RemoveObjects::Plugin;

use strict;
use warnings;

# This method handles both the initial loading of the Remove Objects screen,
# and is also responsible for doing the actual work of deleting objects.
sub remove_objects_interface {
    my $app    = shift;
    my $q      = $app->can('query') ? $app->query : $app->param;
    my $plugin = $app->component('removeobjects');
    my $param  = {};

    # Permissions check -- only system administrators can delete objects here.
    if ( ! $app->user->is_superuser ) {
        return $app->errstr(
            'System Administrator privileges are required to remove objects.'
        );
    }

    # Some object IDs have been supplied. Parse the supplied IDs, try to load
    # them, and delete them.
    if ( $q->param('object_type') && $q->param('object_id') ) {
        my @object_ids = split( /\s?(\d+)\s?,\s?/, $q->param('object_id') );

        my $iter = $app->model( $q->param('object_type') )->load_iter({
            id => \@object_ids,
        });

        my @deleted_ids;
        while ( my $obj = $iter->() ) {
            $obj->remove;

            push @deleted_ids, $obj->id;
        }

        # If anything was deleted, we want to tell the user about it.
        if (@deleted_ids) {
            $param->{objects_removed} = join(', ', @deleted_ids);

            $app->log({
                level     => $app->model('log')->INFO(),
                class     => 'removeobjects',
                author_id => $app->user->id,
                message   => 'The Remove Objects plugin was used to remove '
                    . 'objects of type "' . $q->param('object_type')
                    . '" with the IDs: ' . $param->{objects_removed} . '.',
            });
        }
    }

    my $object_types = $app->registry('object_types');
    my @types;
    foreach my $type (
        sort { $object_types->{$a} cmp $object_types->{$b} }
            keys %{$object_types}
    ) {
        my $label = eval { $app->model($type)->class_label_plural }
            || 'Unkown Label';

        push @types, {
            type  => $type,
            label => $label,
        };
    }
    $param->{object_types} = \@types;

    return $plugin->load_tmpl( 'remove-objects.tmpl', $param );
}

1;
