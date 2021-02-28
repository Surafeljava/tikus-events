
class UpdateEvent extends StatefulWidget {
  static const routeName = 'updateEvent';
  final EventArgument args;

  UpdateEvent({this.args});
  @override
  _AddUpdateCourseState createState() => _AddUpdateCourseState();
}

class _AddUpdateCourseState extends State<UpdateEvent> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _event = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Course" : "Add New Course"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  initialValue: widget.args.edit ? widget.args.event.title : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Event title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Event Title'),
                  onSaved: (value) {
                    this._event["title"] = value;
                  }),
              TextFormField(
                  initialValue: widget.args.edit
                      ? widget.args.event.eventid.toString()
                      : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Organizer';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Event Organizer'),
                  onSaved: (value) {
                    setState(() {
                      this._event["organizer"] = value;
                    });
                  }),
                  TextFormField(
                  initialValue: widget.args.edit ? widget.args.event.typeevent : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Type';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Event Type'),
                  onSaved: (value) {
                    setState(() {
                      this._event["typeevent"] = value;
                    });
                  }),
              //decoration: InputDecoration(labelText: 'Event deadline'),

              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.event.description : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter event description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'event Description'),
                  onSaved: (value) {
                    setState(() {
                      this._event["descriptions"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final EventManager event = widget.args.edit
                          ? EventUpdate(
                              Event(
                                eventid: widget.args.event.eventid,
                                typeevent: this._event["typeevent"],
                                title: this._event["title"],
                                organizer: this._event["organizer"],
                                description: this._event["descriptions"],
                              ),
                            )
                          : EventCreate(
                              Event(
                                typeevent: this._event["typeevent"],
                                title: this._event["title"],
                                organizer: this._event["organizer"],
                                description: this._event["descriptions"],
                              ),
                            );
                      BlocProvider.of<EventBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          EventListbuilder.routeName, (route) => false);
                    }
                  },
                  label: Text('SAVE'),
                  icon: Icon(Icons.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
