from i3ipc import Connection

i3 = Connection()
tree = i3.get_tree()
focused = tree.find_focused()

if focused and focused.parent:
    print(focused.parent.layout)