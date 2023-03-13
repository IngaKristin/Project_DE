import { MongoClient } from 'mongodb';
const mUri = 'mongodb://root:fg3259prf91fni239dduSGh245@localhost:27019/gp9?authSource=admin&readPreference=primary&appname=MongoDB%20Compass&directConnection=true&ssl=false';
const client = new MongoClient(mUri);
const TIMEOUT = 1000000;
/**
 *
 */
export async function agg() {
    try {
        await client.connect();
        const res = await client.db('gp9')
            .collection('reddit')
            .aggregate([
            {
                $limit: 10000000,
            },
            {
                $project: {
                    wordCount: {
                        $size: {
                            $split: ['$body', ' '],
                        }
                    },
                    createdAt: 1,
                },
            },
            {
                $group: {
                    _id: {
                        $dateToString: {
                            format: '%Y-%m-%d %H',
                            date: {
                                $toDate: {
                                    $multiply: [1000, '$createdAt'],
                                },
                            },
                        },
                    },
                    sum: { $sum: '$wordCount' },
                },
            },
        ])
            .toArray();
        console.log(res);
    }
    catch (exc) {
        console.log(exc);
    }
}
const startedAt = Date.now();
agg();
